class BookingEntity {
  final String guestName;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int nightsCount;
  final double pricePerNight;
  final double totalPrice;
  final String employeeName;
  final String? notes;

  BookingEntity({
    required this.guestName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.nightsCount,
    required this.pricePerNight,
    required this.totalPrice,
    required this.employeeName,
    this.notes,
  });
}
