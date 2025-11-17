import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/booking_management/domin/repos/booking_repo.dart';

import '../../../../core/entites/booking_entity.dart';
import '../../../rooms/domin/entites/room_entity.dart';

part 'booking_room_state.dart';

class BookingRoomCubit extends Cubit<BookingRoomState> {
  BookingRoomCubit(this.bookingRepo) : super(BookingRoomInitial());

  final BookingRepo bookingRepo;
  final formKey = GlobalKey<FormState>();
  List<BookingEntity> allBookings = [];
  List<BookingEntity> filteredBookings = [];
  final TextEditingController guestNameController = TextEditingController();
  final TextEditingController guestName2Controller = TextEditingController();
  final TextEditingController pricePerNightController = TextEditingController(
    text: '0',
  );
  final TextEditingController totalPriceController = TextEditingController(
    text: '0',
  );
  final TextEditingController nightsCountController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController(
    text: '0',
  );
  final TextEditingController remainingAmountController = TextEditingController(
    text: '0',
  );
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DateTime? selectedCheckInDate;
  DateTime? selectedCheckOutDate;

  String? paymentMethod;
  final List<String> paymentMethods = [
    'كاش',
    'فيزا',
    'إنستا باي',
    'فودافون كاش',
    'أورانج كاش',
    'تحويل بنكى',
    'وى كاش',
    'اتصالات كاش',
  ];

  Timer? _debounce;

  void updatePricePerNight(String value) {
    pricePerNightController.text = value;
    _updateNightsAndPrice();
  }

  void updateCheckInDate(DateTime date) {
    selectedCheckInDate = date;
    _updateNightsAndPrice();
  }

  void updateCheckOutDate(DateTime date) {
    selectedCheckOutDate = date;
    _updateNightsAndPrice();
  }

  void updatePaidAmount(String value) {
    final paid = int.tryParse(value) ?? 0;
    final total = int.tryParse(totalPriceController.text) ?? 0;
    final remaining = total - paid;
    remainingAmountController.text = remaining > 0 ? remaining.toString() : '0';
  }

  void updatePaymentMethod(String value) {
    paymentMethod = value;
  }

  void setCustmerText(TextEditingController controller, String suggestion) {
    controller.text = suggestion;
  }

  List<BookingEntity> getStatusConut(String status) {
    switch (status) {
      case 'إجمالي الحجوزات':
        return allBookings;
      case 'قيد الانتظار':
        return allBookings
            .where((bookings) => bookings.stutasBooking == 'نشط')
            .toList();
      case 'ملغية':
        return allBookings
            .where((bookings) => bookings.stutasBooking == 'ملغي')
            .toList();
      case 'مكتملة':
        return allBookings
            .where((bookings) => bookings.stutasBooking == 'مكتمل')
            .toList();
      default:
        return [];
    }
  }

  getListForStatus(String status) {
    List<BookingEntity> bookings = getStatusConut(status);
    emit(BookingGetDataSuccess(bookings: bookings));
  }

  String getDaysDifferenceText(DateTime checkIn, DateTime checkOut) {
    int days = checkOut.difference(checkIn).inDays;
    if (days <= 0) return "0 يوم";
    switch (days) {
      case 1:
        return "يوم";
      case 2:
        return "يومين";
      default:
        return "$days أيام";
    }
  }

  void _updateNightsAndPrice() {
    if (selectedCheckInDate != null && selectedCheckOutDate != null) {
      final nights =
          selectedCheckOutDate!.difference(selectedCheckInDate!).inDays;
      nightsCountController.text = getDaysDifferenceText(
        selectedCheckInDate!,
        selectedCheckOutDate!,
      );
      final price = int.tryParse(pricePerNightController.text) ?? 0;
      totalPriceController.text = (nights * price).toString();
      updatePaidAmount(paidAmountController.text);
    }
  }

  bool hasConflictBooking({
    required String roomId,
    required DateTime newCheckIn,
    required DateTime newCheckOut,
  }) {
    for (final booking in allBookings) {
      if (booking.stutasBooking != 'ملغي') {
        final existingCheckIn = booking.checkInDate;
        final existingCheckOut = booking.checkOutDate;

        // هنا بنشوف هل التواريخ متداخلة ولا لأ
        final bool isOverlap =
            newCheckIn.isBefore(existingCheckOut) &&
            newCheckOut.isAfter(existingCheckIn);

        if (isOverlap) {
          log('❌ Conflict detected with booking: ${booking.bookingID}');
          return true;
        }
      }
    }
    return false;
  }

  Future<void> bookingRoom({required final RoomEntity room}) async {
    String id = (10000 + math.Random().nextInt(900000)).toString();

    BookingEntity bookingEntity = BookingEntity(
      guestName: guestNameController.text.trim(),
      guestName2: guestName2Controller.text.trim(),
      roomID: room.roomId!,
      checkInDate: selectedCheckInDate!,
      checkOutDate: selectedCheckOutDate!,
      nightsCount: nightsCountController.text,
      pricePerNight: double.tryParse(pricePerNightController.text) ?? 0,
      totalPrice: double.tryParse(totalPriceController.text) ?? 0,
      employeeName: employeeNameController.text.trim(),
      notes: notesController.text.isNotEmpty ? notesController.text : null,
      paidType: paymentMethod!,
      paidAmount: double.tryParse(paidAmountController.text) ?? 0,
      stutasBooking: 'نشط',
    );

    // ✅ تحقق إن الغرفة مش محجوزة في نفس الوقت
    final hasConflict = allBookings.any((b) {
      if (b.roomID != room.roomId) return false;
      if (b.stutasBooking == 'ملغي' || b.stutasBooking == 'مكتمل') return false;

      // تحقق من التواريخ (overlap)
      final existingStart = b.checkInDate;
      final existingEnd = b.checkOutDate;
      final newStart = selectedCheckInDate!;
      final newEnd = selectedCheckOutDate!;

      final isOverlapping =
          newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart);

      return isOverlapping;
    });

    if (hasConflict) {
      emit(
        BookingRoomError(
          message: '❌ الغرفة رقم ${room.roomId} محجوزة بالفعل في نفس الفترة.',
        ),
      );
      getBookings();
      return;
    }

    // ✅ تحقق لو العميل عنده حجز نشط آخر
    final customerBookings = allBookings.where(
      (b) => b.guestName == guestNameController.text,
    );

    final hasActiveBooking = customerBookings.any(
      (b) => b.stutasBooking != 'مكتمل' && b.stutasBooking != 'ملغي',
    );

    if (hasActiveBooking) {
      emit(
        BookingRoomError(
          message: '❌ العميل ${guestNameController.text} لديه حجز آخر نشط.',
        ),
      );
      getBookings();
      return;
    }

    emit(BookingRoomLoading());
    bookingEntity.bookingID =
        'INV-$id-${selectedCheckInDate!.year}${selectedCheckInDate!.month}${selectedCheckInDate!.day}';
    final failureOrSuccess = await bookingRepo.addBooking(
      booking: bookingEntity,
    );

    if (isClosed) return;

    failureOrSuccess.fold(
      (failure) {
        clearControls();
        emit(BookingRoomError(message: failure.errMessage));
      },
      (_) {
        clearControls();
        emit(BookingRoomSuccess());
      },
    );
  }

  Future<void> getBookings() async {
    emit(BookingRoomLoading());
    final failureOrSuccess = await bookingRepo.getAllBookings();
    failureOrSuccess.fold(
      (failure) {
        clearControls();
        emit(BookingRoomError(message: failure.errMessage));
      },
      (bookings) async {
        log('Fetched bookings: $bookings');
        allBookings = bookings; // نحفظ الأصلية
        filteredBookings = List.from(bookings); // نبدأ منها
        // await updateRoomStatusAfterCheckOut();
        emit(BookingGetDataSuccess(bookings: filteredBookings));
      },
    );
  }

  void search(String query) {
    if (isClosed) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (isClosed) return;
      _filterAndSearchBookings(query);
    });
  }

  BookingEntity getBookingByIdRoom({required String idRoom}) {
    var b = allBookings.where((booking) {
      return booking.stutasBooking.toString().contains('نشط');
    });
    BookingEntity booking = b.firstWhere(
      (booking) => booking.roomID.toString() == idRoom,
    );
    return booking;
  }

  void _filterAndSearchBookings(String query) {
    if (isClosed) return;

    query = query.trim().toLowerCase();
    if (query.isEmpty) {
      filteredBookings = List.from(allBookings);
    } else {
      filteredBookings =
          allBookings.where((booking) {
            return booking.roomID.toString().contains(query) ||
                booking.guestName!.toLowerCase().contains(query) ||
                (booking.guestName2?.toLowerCase().contains(query) ?? false);
          }).toList();
    }

    if (!isClosed) {
      emit(BookingGetDataSuccess(bookings: filteredBookings));
    }
  }

  void updateBookingState({
    required BookingEntity booking,
    required String status,
  }) async {
    // تحديث حالة الحجز الحالية
    final updatedBooking = BookingEntity(
      bookingID: booking.bookingID,
      roomID: booking.roomID,
      paidAmount: booking.totalPrice,
      paidType: booking.paidType,
      guestName: booking.guestName,
      checkInDate: booking.checkInDate,
      checkOutDate: booking.checkOutDate,
      nightsCount: booking.nightsCount,
      pricePerNight: booking.pricePerNight,
      totalPrice: booking.totalPrice,
      employeeName: booking.employeeName,
      stutasBooking: status,
      guestName2: booking.guestName2,
      notes: booking.notes,
    );

    await bookingRepo.updateBookingStatus(booking: updatedBooking);

    // ✅ قبل ما نحدث حالة الغرفة، نتحقق هل في حجز تاني على نفس الأوضة بعد تاريخ الخروج
    final roomId = booking.roomID;
    final checkOutDate = booking.checkOutDate;

    final hasFutureBooking = allBookings.any(
      (b) =>
          b.roomID == roomId &&
          b.stutasBooking != 'ملغي' &&
          b.stutasBooking != 'مكتمل' &&
          b.checkInDate.isAfter(checkOutDate),
    );

    if (hasFutureBooking) {
      // لو فيه حجز جاي على نفس الغرفة
      await bookingRepo.updateRoomStatus(roomId: roomId, newStatus: 'محجوز');
      log('🟡 الغرفة $roomId فيها حجز قادم → تظل حالتها "محجوزة"');
    } else {
      // لو مفيش أي حجز قادم
      await bookingRepo.updateRoomStatus(roomId: roomId, newStatus: 'متاح');
      log('🟢 الغرفة $roomId أصبحت "متاحة" بعد اكتمال/إلغاء الحجز');
    }

    emit(UpdateStateBooking());
    getBookings();
  }

  void deleteBooking({required BookingEntity booking}) async {
    if (booking.stutasBooking == 'نشط') {
      emit(BookingRoomError(message: 'لا يمكن حذف الحجز لانه مزال نشط'));
      return;
    }
    final result = await bookingRepo.deleteBooking(booking.bookingID!);
    result.fold(
      (failure) {
        emit(BookingRoomError(message: failure.errMessage));
        getBookings();
      },
      (_) {
        emit(DeleteBooking());
        getBookings();
      },
    );
  }

  void clearControls() {
    guestNameController.clear();
    notesController.clear();
    nightsCountController.clear();
    totalPriceController.clear();
    paidAmountController.clear();
    remainingAmountController.clear();
    employeeNameController.clear();
    paymentMethod = null;
    selectedCheckInDate = null;
    selectedCheckOutDate = null;
  }

  @override
  Future<void> close() {
    guestNameController.dispose();
    notesController.dispose();
    nightsCountController.dispose();
    pricePerNightController.dispose();
    totalPriceController.dispose();
    paidAmountController.dispose();
    remainingAmountController.dispose();
    employeeNameController.dispose();
    _debounce?.cancel();
    return super.close();
  }

  // Future<void> updateRoomStatusAfterCheckOut() async {
  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);

  //   for (final booking in allBookings) {
  //     final checkOutDay = DateTime(
  //       booking.checkOutDate.year,
  //       booking.checkOutDate.month,
  //       booking.checkOutDate.day,
  //     );

  //     // ✅ الشرط الجديد: لو تاريخ الخروج <= النهارده
  //     final bool isEnded =
  //         checkOutDay.isBefore(today) || checkOutDay.isAtSameMomentAs(today);

  //     if (isEnded &&
  //         booking.stutasBooking != 'مكتمل' &&
  //         booking.stutasBooking != 'ملغي') {
  //       final roomId = booking.roomID;

  //       debugPrint(
  //         '🔵 الحجز ${booking.bookingID} انتهى - تحديث حالته إلى مكتمل',
  //       );

  //       // ✅ نحدث حالة الحجز
  //       await bookingRepo.updateBookingStatus(
  //         bookingId: booking.bookingID!,
  //         newStatus: 'مكتمل',
  //       );

  //       // ✅ نتحقق لو فيه حجز آخر على نفس الأوضة بعد التاريخ ده
  //       final hasActiveOrFutureBooking = allBookings.any(
  //         (b) =>
  //             b.roomID == roomId &&
  //             b.stutasBooking != 'ملغي' &&
  //             b.checkInDate.isAfter(today),
  //       );

  //       if (hasActiveOrFutureBooking) {
  //         await bookingRepo.updateRoomStatus(
  //           roomId: roomId,
  //           newStatus: 'محجوز',
  //         );
  //         debugPrint('🟡 الأوضة $roomId فيها حجز قادم → حالتها محجوزة');
  //       } else {
  //         await bookingRepo.updateRoomStatus(roomId: roomId, newStatus: 'متاح');
  //         debugPrint('🟢 الأوضة $roomId أصبحت متاحة');
  //       }
  //     } else {
  //       debugPrint(
  //         '⏸️ الحجز ${booking.bookingID} لسه شغال أو حالته مكتملة/ملغية',
  //       );
  //     }
  //   }
  // }
}
