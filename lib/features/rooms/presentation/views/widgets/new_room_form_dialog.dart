import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../cubits/rooms_cubit.dart';
import 'new_room_bloc_builder.dart';

class NewRoomFormDialog extends StatefulWidget {
  const NewRoomFormDialog({super.key, this.roomEntity});
  final RoomEntity? roomEntity;

  @override
  State<NewRoomFormDialog> createState() => _NewRoomFormDialogState();
}

class _NewRoomFormDialogState extends State<NewRoomFormDialog> {
  @override
  void initState() {
    context.read<RoomsCubit>().formController.initFromRoom(widget.roomEntity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NewrRoomBlocBuilder(roomEntity: widget.roomEntity);
  }
}
