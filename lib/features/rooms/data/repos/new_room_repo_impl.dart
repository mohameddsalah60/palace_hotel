import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/services/database_service.dart';
import 'package:palace_systeam_managment/features/rooms/data/models/room_model.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';

class NewRoomRepoImpl implements NewRoomRepo {
  final DatabaseService databaseService;

  NewRoomRepoImpl({required this.databaseService});
  @override
  Future<Either<ApiErrorModel, void>> insertNewRoom({
    required RoomEntity roomEntity,
  }) async {
    try {
      Map<String, dynamic> roomData = RoomModel.fromEntity(roomEntity).toMap();
      await databaseService.addData(path: 'rooms', data: roomData);
      log('Room inserted successfully: $roomData');
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
