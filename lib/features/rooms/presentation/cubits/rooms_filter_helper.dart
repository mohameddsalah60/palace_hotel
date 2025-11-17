import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

class RoomsFilterHelper {
  static List<RoomEntity> apply({
    required List<RoomEntity> allRooms,
    required String selectedFloor,
    required String searchSelectedStatus,
    required String searchSelectedType,
    required String searchQuery,
  }) {
    List<RoomEntity> filtered = List.from(allRooms);

    // Floor filter
    if (selectedFloor != 'الكل') {
      filtered =
          filtered
              .where((room) => room.floorRoom.contains(selectedFloor))
              .toList();
    }

    // Status filter
    if (searchSelectedStatus != 'جميع الحالات') {
      filtered =
          filtered
              .where((room) => room.statusRoom == searchSelectedStatus)
              .toList();
    }

    // Type filter
    if (searchSelectedType != 'جميع الأنواع') {
      filtered =
          filtered
              .where((room) => room.typeRoom == searchSelectedType)
              .toList();
    }

    // Search query
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      filtered =
          filtered
              .where(
                (room) =>
                    room.roomId.toString().toLowerCase().contains(q) ||
                    room.typeRoom.toLowerCase().contains(q) ||
                    room.statusRoom.toLowerCase().contains(q),
              )
              .toList();
    }

    return filtered;
  }
}
