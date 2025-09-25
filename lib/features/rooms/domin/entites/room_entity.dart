class RoomEntity {
  final int? roomId;
  final String typeRoom;
  final String floorRoom;
  final String descriptionRoom;
  final int pricePerNight;
  final String statusRoom;

  RoomEntity({
    this.roomId,
    required this.typeRoom,
    required this.floorRoom,
    required this.descriptionRoom,
    required this.pricePerNight,
    required this.statusRoom,
  });
}
