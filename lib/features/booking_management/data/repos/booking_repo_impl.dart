import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/models/booking_model.dart';

import '../../../../core/services/local_database.dart';
import '../../domin/repos/booking_repo.dart';

class BookingRepoImpl extends BookingRepo {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<void> updateBookingStatus({required BookingEntity booking}) async {
    try {
      Map<String, dynamic> bookingData =
          BookingModel.fromEntity(booking).toMap();
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'bookings',
        bookingData,
        where: 'bookingID = ?',
        whereArgs: [booking.bookingID],
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
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'rooms',
      {'statusRoom': newStatus},
      where: 'roomId = ?',
      whereArgs: [roomId],
    );
  }

  @override
  Future<Either<ApiErrorModel, void>> addBooking({
    required BookingEntity booking,
  }) async {
    try {
      Map<String, dynamic> bookingData =
          BookingModel.fromEntity(booking).toMap();
      await databaseHelper.insertData(table: 'bookings', row: bookingData);
      await databaseHelper.updateData(
        table: 'rooms',
        row: {'statusRoom': 'محجوز'},
        id: booking.roomID,
        idColumn: 'roomId',
      );

      log('booking inserted successfully: $bookingData');
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> deleteBooking(int bookingID) async {
    try {
      await databaseHelper.deleteData(
        table: 'bookings',
        id: bookingID,
        idColumn: 'bookingID',
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, List<BookingEntity>>> getAllBookings() async {
    try {
      final bookingsData = await databaseHelper.queryAllData(table: 'bookings');
      final bookings =
          bookingsData.map((data) => BookingModel.fromJson(data)).toList();
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
      await databaseHelper.updateData(
        table: 'bookings',
        row: bookingData,
        id: booking.bookingID,
        idColumn: 'bookingID',
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
