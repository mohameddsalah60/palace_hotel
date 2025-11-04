import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../cubits/rooms_cubit.dart';
import 'new_room_bloc_builder.dart';

class NewRoomFormDialog extends StatelessWidget {
  const NewRoomFormDialog({super.key, this.roomEntity});
  final RoomEntity? roomEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<RoomsCubit>()..formController.initFromRoom(roomEntity),
      child: NewrRoomBlocBuilder(roomEntity: roomEntity),
    );
  }
}
