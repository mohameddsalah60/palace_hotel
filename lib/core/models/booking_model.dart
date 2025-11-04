import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required super.roomID,
    required super.guestName,
    required super.checkInDate,
    required super.paidAmount,
    required super.paidType,
    required super.checkOutDate,
    required super.nightsCount,
    required super.pricePerNight,
    required super.totalPrice,
    required super.employeeName,
    super.notes,
    super.bookingID,
    super.guestName2,
    super.stutasBooking,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      roomID: json['roomID'],
      guestName: json['guestName'] ?? '',
      guestName2: json['guestName2'] ?? '',
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      nightsCount: json['nightsCount']?.toString() ?? '0',
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      employeeName: json['employeeName'] ?? '',
      notes: json['notes'] ?? '',
      bookingID: json['bookingID'],
      paidType: json['paidType'] ?? '',
      paidAmount: (json['paidAmount'] ?? 0).toDouble(),
      stutasBooking: json['stutasBooking'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'roomID': roomID,
      'guestName': guestName,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'nightsCount': nightsCount,
      'pricePerNight': pricePerNight,
      'totalPrice': totalPrice,
      'employeeName': employeeName,
      'notes': notes,
      'guestName2': guestName2,
      'paidType': paidType,
      'paidAmount': paidAmount,
      'stutasBooking': stutasBooking,
    };
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      roomID: entity.roomID,
      paidType: entity.paidType,
      guestName: entity.guestName,
      checkInDate: entity.checkInDate,
      checkOutDate: entity.checkOutDate,
      nightsCount: entity.nightsCount,
      pricePerNight: entity.pricePerNight,
      totalPrice: entity.totalPrice,
      employeeName: entity.employeeName,
      notes: entity.notes,
      bookingID: entity.bookingID,
      guestName2: entity.guestName2,
      paidAmount: entity.paidAmount,
      stutasBooking: entity.stutasBooking,
    );
  }
}
