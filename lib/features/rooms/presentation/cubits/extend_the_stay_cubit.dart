import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entites/booking_entity.dart';
import '../../../booking_management/domin/repos/booking_repo.dart';
import '../../domin/entites/room_entity.dart';

part 'extend_the_stay_state.dart';

class ExtendTheStayCubit extends Cubit<ExtendTheStayState> {
  ExtendTheStayCubit(this.bookingRepo) : super(ExtendTheStayInitial());

  final BookingRepo bookingRepo;
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController paidAmountController = TextEditingController(
    text: '0',
  );
  final TextEditingController totalExtendPriceController =
      TextEditingController(text: '0');
  final TextEditingController remainingAmountController = TextEditingController(
    text: '0',
  );

  DateTime? selectedCheckOutDate;
  double? pricePerNight;
  DateTime? oldCheckOutDate;

  /// تحديث تاريخ المغادرة الجديد
  void updateSelectedCheckOutDate(DateTime newDate) {
    selectedCheckOutDate = newDate;
    _updateExtendSummary();
  }

  /// حساب عدد الأيام بشكل نصي
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

  void updatePaidAmount(String value) {
    final paid = double.tryParse(value) ?? 0;
    final total = double.tryParse(totalExtendPriceController.text) ?? 0;
    final remaining = total - paid;
    remainingAmountController.text =
        remaining > 0 ? remaining.toStringAsFixed(0) : '0';
    emit(ExtendTheStaySummaryUpdated());
  }

  void _updateExtendSummary() {
    if (selectedCheckOutDate == null ||
        oldCheckOutDate == null ||
        pricePerNight == null) {
      return;
    }

    final days = selectedCheckOutDate!.difference(oldCheckOutDate!).inDays;
    final total = days * pricePerNight!;
    totalExtendPriceController.text = total.toStringAsFixed(0);

    final paid = double.tryParse(paidAmountController.text) ?? 0;
    final remaining = total - paid;
    remainingAmountController.text =
        remaining > 0 ? remaining.toStringAsFixed(0) : '0';

    emit(ExtendTheStaySummaryUpdated());
  }

  Future<void> confirmExtendStay({required BookingEntity booking}) async {
    if (!formKey.currentState!.validate()) return;

    emit(ExtendTheStayLoading());

    // 🧮 حساب القيم القديمة
    final oldTotal = booking.totalPrice;
    final oldPaid = booking.paidAmount;

    // 🧮 القيم الجديدة الخاصة بالتمديد
    final extendTotal = double.tryParse(totalExtendPriceController.text) ?? 0;
    final extendPaid = double.tryParse(paidAmountController.text) ?? 0;

    // 🧮 جمع القيم
    final newTotal = oldTotal + extendTotal;
    final newPaid = oldPaid + extendPaid;
    final newRemaining = newTotal - newPaid;

    // 🏨 إنشاء الحجز الجديد بعد التمديد
    final updatedBooking = BookingEntity(
      roomID: booking.roomID,
      paidAmount: newPaid,
      paidType: booking.paidType,
      guestName: booking.guestName,
      checkInDate: booking.checkInDate,
      checkOutDate: selectedCheckOutDate!,
      nightsCount: getDaysDifferenceText(
        booking.checkInDate,
        selectedCheckOutDate!,
      ),
      pricePerNight: pricePerNight!,
      totalPrice: newTotal,
      employeeName: booking.employeeName,
      stutasBooking: 'نشط',
      bookingID: booking.bookingID,
      notes: booking.notes,
      guestName2: booking.guestName2,
    );

    final result = await bookingRepo.updateBooking(updatedBooking);
    result.fold((failure) => emit(ExtendTheStayError(failure.errMessage)), (_) {
      log(
        '✅ Extension success: Total = $newTotal, Paid = $newPaid, Remaining = $newRemaining',
      );
      emit(ExtendTheStaySuccess());
    });
  }

  /// تجهيز البيانات قبل الفتح
  void initializeData({
    required RoomEntity room,
    required BookingEntity booking,
  }) {
    oldCheckOutDate = booking.checkOutDate;
    pricePerNight = double.tryParse(room.pricePerNight.toString());
    selectedCheckOutDate = booking.checkOutDate;
    paidAmountController.text = '0';
    totalExtendPriceController.text = '0';
    remainingAmountController.text = '0';
    emit(ExtendTheStayInitial());
  }

  @override
  Future<void> close() {
    paidAmountController.dispose();
    totalExtendPriceController.dispose();
    remainingAmountController.dispose();
    return super.close();
  }
}
