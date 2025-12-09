import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/services/database_service.dart';
import 'package:palace_systeam_managment/features/rooms/data/models/room_model.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';

class RoomsRepoImpl implements RoomsRepo {
  final DatabaseService databaseService;

  RoomsRepoImpl({required this.databaseService});
  @override
  Future<Either<ApiErrorModel, void>> deleteRoom({
    required RoomEntity roomEntity,
  }) async {
    try {
      await databaseService.deleteData(
        path: 'rooms',
        supPath: 'roomId',
        value: roomEntity.roomId,
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<ApiErrorModel, List<RoomEntity>>> getAllRooms() async* {
    try {
      await for (var data in databaseService.streamData(path: 'rooms')) {
        List<RoomEntity> orders =
            (data as List<dynamic>)
                .map<RoomEntity>((e) => RoomModel.fromMap(e))
                .toList();
        yield Right(orders);
      }
    } catch (e) {
      log(e.toString());
      yield left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> updateRoom({
    required RoomEntity roomEntity,
  }) async {
    try {
      Map<String, dynamic> room = RoomModel.fromEntity(roomEntity).toMap();
      await databaseService.updateData(
        path: 'rooms',
        supPath: 'roomId',
        oldVALUE: room,
        newVALUE: roomEntity.roomId,
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
