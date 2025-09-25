import 'package:dartz/dartz.dart';

import '../../../../core/errors/api_error_model.dart';
import '../entites/room_entity.dart';

abstract class RoomsRepo {
  Future<Either<ApiErrorModel, List<RoomEntity>>> getAllRooms();
  Future<Either<ApiErrorModel, void>> deleteRoom({required int roomId});
  Future<Either<ApiErrorModel, void>> updateRoom({
    required RoomEntity roomEntity,
  });
}
