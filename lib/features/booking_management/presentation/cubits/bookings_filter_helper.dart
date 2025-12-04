import '../../../../core/entites/booking_entity.dart';

class BookingFilterHelper {
  static List<BookingEntity> filterBookings({
    required List<BookingEntity> allBookings,
    String? query,
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
    String? sort,
  }) {
    List<BookingEntity> result = allBookings;

    // بحث
    if (query != null && query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
      result =
          result.where((b) {
            return b.roomID.toString().contains(q) ||
                b.guestName!.toLowerCase().contains(q) ||
                (b.guestName2?.toLowerCase().contains(q) ?? false);
          }).toList();
    }

    // حالة الحجز
    if (status != null && status != 'الكل') {
      result = result.where((b) => b.stutasBooking == status).toList();
    }

    // تاريخ من
    if (fromDate != null) {
      result =
          result
              .where(
                (b) => !b.checkInDate.isBefore(fromDate),
              ) // يشمل اليوم نفسه
              .toList();
    }

    // تاريخ إلى
    if (toDate != null) {
      result =
          result
              .where((b) => !b.checkOutDate.isAfter(toDate)) // يشمل اليوم نفسه
              .toList();
    }

    // ترتيب
    if (sort == "الاحدث اولآ") {
      result.sort((a, b) => b.checkInDate.compareTo(a.checkInDate));
    } else if (sort == "الاقدم اولآ") {
      result.sort((a, b) => a.checkInDate.compareTo(b.checkInDate));
    }

    return result;
  }
}
