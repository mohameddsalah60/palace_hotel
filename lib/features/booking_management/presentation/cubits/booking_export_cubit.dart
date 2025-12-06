import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

import '../../../../core/helpers/export_bookings_to_excel.dart';

part 'booking_export_state.dart';

class BookingExportCubit extends Cubit<BookingExportState> {
  BookingExportCubit() : super(BookingExportInitial());
  DateTime? from, to;
  void exportBookings({required List<BookingEntity> bookings}) async {
    emit(BookingExportLoading());

    try {
      await exportBookingsToExcel(
        bookings: bookings,
        from: from ?? DateTime.now(),
        to: to ?? DateTime.now(),
      );
      emit(BookingExportSuccess());
    } catch (e) {
      emit(BookingExportFailure(error: e.toString()));
    }
  }
}
