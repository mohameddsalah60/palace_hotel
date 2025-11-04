import 'package:flutter/material.dart';

class BookingEntity {
  final String? guestName, guestName2, stutasBooking;
  final int roomID;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String nightsCount;
  final double pricePerNight, paidAmount;
  final double totalPrice;
  final String employeeName;
  final String paidType;
  final String? notes;
  final int? bookingID;

  BookingEntity({
    this.guestName2,
    this.bookingID,
    this.stutasBooking,
    required this.roomID,
    required this.paidAmount,
    required this.paidType,
    required this.guestName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.nightsCount,
    required this.pricePerNight,
    required this.totalPrice,
    required this.employeeName,
    this.notes,
  });

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'نشط':
        return Colors.green;
      case 'ملغي':
        return Colors.red;
      case 'مكتمل':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
