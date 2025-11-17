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
      log('Trying to add room: $roomData');
      await databaseService.addData(
        path: 'rooms',
        data: roomData,
        docId: roomEntity.roomId.toString(),
      );
      log('✅ Room added successfully');
      return right(null);
    } catch (e, st) {
      log('❌ Failed to add room: $e\n$st');
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
