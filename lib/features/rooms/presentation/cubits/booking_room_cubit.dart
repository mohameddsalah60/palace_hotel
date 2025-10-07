import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/booking_management/domin/repos/booking_repo.dart';

import '../../../../core/entites/booking_entity.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../booking_management/domin/entites/booking_status_entity.dart';
import '../../domin/entites/room_entity.dart';

part 'booking_room_state.dart';

class BookingRoomCubit extends Cubit<BookingRoomState> {
  BookingRoomCubit(this.bookingRepo) : super(BookingRoomInitial());

  final BookingRepo bookingRepo;
  final formKey = GlobalKey<FormState>();
  List<BookingEntity> allBookings = []; // كل الحجوزات الأصلية
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
  ];

  Timer? _debounce;

  void updatePricePerNight(String value) {
    pricePerNightController.text = value;
    _updateNightsAndPrice();
    emit(BookingRoomInitial());
  }

  void updateCheckInDate(DateTime date) {
    selectedCheckInDate = date;
    _updateNightsAndPrice();
    emit(BookingRoomInitial());
  }

  void updateCheckOutDate(DateTime date) {
    selectedCheckOutDate = date;
    _updateNightsAndPrice();
    emit(BookingRoomInitial());
  }

  void updatePaidAmount(String value) {
    final paid = int.tryParse(value) ?? 0;
    final total = int.tryParse(totalPriceController.text) ?? 0;
    final remaining = total - paid;
    remainingAmountController.text = remaining > 0 ? remaining.toString() : '0';
    emit(BookingRoomInitial());
  }

  void updatePaymentMethod(String value) {
    paymentMethod = value;
    emit(BookingRoomInitial());
  }

  void setCustmerText(TextEditingController controller, String suggestion) {
    controller.text = suggestion;
    emit(BookingRoomInitial());
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

  bookingRoom({required final RoomEntity room}) async {
    BookingEntity bookingEntity = BookingEntity(
      guestName: guestNameController.text,
      guestName2: guestName2Controller.text,
      roomID: room.roomId!,
      checkInDate: selectedCheckInDate!,
      checkOutDate: selectedCheckOutDate!,
      nightsCount: nightsCountController.text,
      pricePerNight: double.tryParse(pricePerNightController.text) ?? 0,
      totalPrice: double.tryParse(totalPriceController.text) ?? 0,
      employeeName: employeeNameController.text,
      notes: notesController.text.isNotEmpty ? notesController.text : null,
      paidType: paymentMethod!,
      paidAmount: double.tryParse(paidAmountController.text) ?? 0,
    );
    log(bookingEntity.toString());
    final failureOrSuccess = await bookingRepo.addBooking(
      booking: bookingEntity,
    );
    failureOrSuccess.fold(
      (failure) {
        emit(BookingRoomError(message: failure.errMessage));
      },
      (success) {
        emit(BookingRoomSuccess());
      },
    );
  }

  Future<void> getBookings() async {
    emit(BookingRoomLoading());
    final failureOrSuccess = await bookingRepo.getAllBookings();
    failureOrSuccess.fold(
      (failure) {
        emit(BookingRoomError(message: failure.errMessage));
      },
      (bookings) {
        log('Fetched bookings: $bookings');
        allBookings = bookings; // نحفظ الأصلية
        filteredBookings = List.from(bookings); // نبدأ منها
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
}
