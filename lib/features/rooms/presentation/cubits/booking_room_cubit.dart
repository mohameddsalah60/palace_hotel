import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/booking_entity.dart';

import '../../domin/entites/room_entity.dart';

part 'booking_room_state.dart';

class BookingRoomCubit extends Cubit<BookingRoomState> {
  BookingRoomCubit() : super(BookingRoomInitial());

  final formKey = GlobalKey<FormState>();

  final TextEditingController guestNameController = TextEditingController();
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
  final List<String> paymentMethods = ['كاش', 'فيزا', 'إنستا باي'];

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

  bookingRoom({required final RoomEntity room}) {
    BookingEntity bookingEntity = BookingEntity(
      guestName: guestNameController.text,
      checkInDate: selectedCheckInDate!,
      checkOutDate: selectedCheckOutDate!,
      nightsCount: int.tryParse(nightsCountController.text) ?? 0,
      pricePerNight: double.tryParse(pricePerNightController.text) ?? 0,
      totalPrice: double.tryParse(totalPriceController.text) ?? 0,
      employeeName: employeeNameController.text,
      notes: notesController.text.isNotEmpty ? notesController.text : null,
    );
    log(bookingEntity.toString());
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
    return super.close();
  }
}
