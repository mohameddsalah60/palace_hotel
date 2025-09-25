import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

abstract class NewRoomRepo {
  Future<Either<ApiErrorModel, void>> insertNewRoom({
    required RoomEntity roomEntity,
  });
}
