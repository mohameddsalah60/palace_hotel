import 'package:flutter/material.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/booking_room_dialog_body.dart';

import '../../../domin/entites/room_entity.dart';

class BookingRoomDialog extends StatelessWidget {
  const BookingRoomDialog({super.key, required this.roomEntity});
  final RoomEntity roomEntity;
  @override
  Widget build(BuildContext context) {
    return BookingRoomDialogBody(roomEntity: roomEntity);
  }
}
