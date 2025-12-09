import 'package:dartz/dartz.dart';

import '../../../../core/errors/api_error_model.dart';
import '../entites/room_entity.dart';

abstract class RoomsRepo {
  Stream<Either<ApiErrorModel, List<RoomEntity>>> getAllRooms();
  Future<Either<ApiErrorModel, void>> deleteRoom({
    required RoomEntity roomEntity,
  });
  Future<Either<ApiErrorModel, void>> updateRoom({
    required RoomEntity roomEntity,
  });
}
