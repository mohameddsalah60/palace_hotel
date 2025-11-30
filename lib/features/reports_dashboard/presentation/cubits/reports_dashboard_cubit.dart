import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

part 'reports_dashboard_state.dart';

class ReportsDashboardCubit extends Cubit<ReportsDashboardState> {
  ReportsDashboardCubit() : super(ReportsDashboardInitial());
  double getTotalByPaymentMethod({
    required List<BookingEntity> bookings,
    String? paymentType,
  }) {
    double total = 0;
    final now = DateTime.now();

    final walletMethods = ["فودافون كاش", "أورانج كاش", "اتصالات كاش"];

    // هتخزن الـ bookingID اللي اتحسبت عشان متتكررش
    final Set<String> countedBookingIDs = {};

    for (var booking in bookings) {
      // اتأكد الحجز للشهر الحالي ومش ملغي
      if (booking.checkInDate.year == now.year &&
          booking.checkInDate.month == now.month &&
          booking.stutasBooking != "ملغي" &&
          !countedBookingIDs.contains(booking.bookingID)) {
        final paidTypeTrim = booking.paidType.trim().toLowerCase();

        if (paymentType == null || paymentType.isEmpty) {
          total += booking.totalPrice;
        } else if (paymentType.toLowerCase() == "wallet" &&
            walletMethods.map((e) => e.toLowerCase()).contains(paidTypeTrim)) {
          total += booking.totalPrice;
        } else if (paidTypeTrim == paymentType.trim().toLowerCase()) {
          total += booking.totalPrice;
        }

        // سجل الـ bookingID عشان متتكررش
        countedBookingIDs.add(booking.bookingID!);
      }
    }

    return total;
  }
}
