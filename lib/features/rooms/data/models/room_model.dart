import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

class RoomModel extends RoomEntity {
  RoomModel({
    super.roomId,
    required super.typeRoom,
    required super.floorRoom,
    required super.descriptionRoom,
    required super.pricePerNight,
    required super.statusRoom,
  });
  Map<String, dynamic> toMap() {
    return {
      if (roomId != null) 'roomId': roomId,
      'typeRoom': typeRoom,
      'floorRoom': floorRoom,
      'descriptionRoom': descriptionRoom,
      'pricePerNight': pricePerNight,
      'statusRoom': statusRoom,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId']?.toInt(),
      typeRoom: map['typeRoom'] ?? '',
      floorRoom: map['floorRoom'] ?? '',
      descriptionRoom: map['descriptionRoom'] ?? '',
      pricePerNight: map['pricePerNight']?.toInt() ?? 0,
      statusRoom: map['statusRoom'] ?? '',
    );
  }

  factory RoomModel.fromEntity(RoomEntity entity) {
    return RoomModel(
      roomId: entity.roomId,
      typeRoom: entity.typeRoom,
      floorRoom: entity.floorRoom,
      descriptionRoom: entity.descriptionRoom,
      pricePerNight: entity.pricePerNight,
      statusRoom: entity.statusRoom,
    );
  }
}
