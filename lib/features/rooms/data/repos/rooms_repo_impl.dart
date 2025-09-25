import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/features/rooms/data/models/room_model.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';

import '../../../../core/services/local_database.dart';

class RoomsRepoImpl implements RoomsRepo {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  @override
  Future<Either<ApiErrorModel, void>> deleteRoom({required int roomId}) {
    // TODO: implement deleteRoom
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiErrorModel, List<RoomEntity>>> getAllRooms() async {
    try {
      final roomsData = await databaseHelper.queryAllData(table: 'rooms');
      final rooms = roomsData.map((data) => RoomModel.fromMap(data)).toList();
      return right(rooms);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> updateRoom({
    required RoomEntity roomEntity,
  }) async {
    try {
      Map<String, dynamic> room = RoomModel.fromEntity(roomEntity).toMap();
      final roomsData = await databaseHelper.updateData(
        row: room,
        table: 'rooms',
        id: roomEntity.roomId!,
        idColumn: 'roomId',
      );
      log(roomsData.toString());
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
