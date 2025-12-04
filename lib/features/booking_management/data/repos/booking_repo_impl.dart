import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/models/booking_model.dart';
import 'package:palace_systeam_managment/core/services/database_service.dart';

import '../../domin/repos/booking_repo.dart';
import '../../../../core/services/email_service.dart';

class BookingRepoImpl extends BookingRepo {
  final DatabaseService databaseService;

  BookingRepoImpl({required this.databaseService});
  @override
  Future<void> updateBookingStatus({required BookingEntity booking}) async {
    try {
      Map<String, dynamic> bookingData =
          BookingModel.fromEntity(booking).toMap();
      await databaseService.updateData(
        path: 'bookings',
        oldVALUE: bookingData,
        newVALUE: 'bookingID',
        supPath: booking.bookingID,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> updateRoomStatus({
    required int roomId,
    required String newStatus,
  }) async {
    await databaseService.updateData(
      path: 'rooms',
      oldVALUE: {'statusRoom': newStatus},
      supPath: roomId.toString(),
      newVALUE: 'roomId',
    );
  }

  @override
  Future<Either<ApiErrorModel, void>> addBooking({
    required BookingEntity booking,
  }) async {
    try {
      Map<String, dynamic> bookingData =
          BookingModel.fromEntity(booking).toMap();
      await databaseService.addData(
        path: 'bookings',
        data: bookingData,
        docId: booking.bookingID.toString(),
      );
      await databaseService.updateData(
        path: 'rooms',
        oldVALUE: {'statusRoom': 'محجوز'},
        supPath: booking.roomID.toString(),
        newVALUE: booking.roomID,
      );
      final emailService = EmailService();

      emailService.sendBookingEmail(
        guestName: booking.guestName.toString(),
        roomID: booking.roomID,
        totalPrice: booking.totalPrice,
        paidAmount: booking.paidAmount,
        remainingAmount: booking.totalPrice - booking.paidAmount,
        checkInDate: DateTime.parse(booking.checkInDate.toString()),
        checkOutDate: DateTime.parse(booking.checkOutDate.toString()),
        ownerEmail: "tktkyttttttttttk@gmail.com",
        empolyee: booking.employeeName,
      );

      return right(null);
    } catch (e) {
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> deleteBooking(String bookingID) async {
    try {
      await databaseService.deleteData(path: 'bookings', value: bookingID);
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, List<BookingEntity>>> getAllBookings() async {
    try {
      final bookingsData = await databaseService.getData(path: 'bookings');
      final List<BookingEntity> bookings =
          (bookingsData as List<dynamic>)
              .map(
                (item) => BookingModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      return right(bookings);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> updateBooking(
    BookingEntity booking,
  ) async {
    try {
      Map<String, dynamic> bookingData =
          BookingModel.fromEntity(booking).toMap();
      await databaseService.updateData(
        path: 'bookings',
        oldVALUE: bookingData,
        newVALUE: 'bookingID',
        supPath: booking.bookingID,
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
