import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';

import '../../../../core/entites/booking_entity.dart';

abstract class BookingRepo {
  Future<Either<ApiErrorModel, void>> addBooking({
    required BookingEntity booking,
  });
  Future<Either<ApiErrorModel, List<BookingEntity>>> getAllBookings();
  Future<Either<ApiErrorModel, void>> updateBooking(BookingEntity booking);
  Future<Either<ApiErrorModel, void>> deleteBooking(String bookingId);
  Future<void> updateBookingStatus({required BookingEntity booking});

  Future<void> updateRoomStatus({
    required int roomId,
    required String newStatus,
  });
}
