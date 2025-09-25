import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import 'widgets/new_room_form_dialog.dart';
import 'widgets/rooms_view_body.dart';
import '../../../../core/widgets/custom_floating_action_button.dart';

class RoomsView extends StatelessWidget {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<RoomsCubit>()..fetchRooms(),
      child: Scaffold(
        backgroundColor: AppColors.wheitDark,
        floatingActionButton: CustomFloatingActionButton(
          child: NewRoomFormDialog(),
        ),
        body: RoomsViewBody(),
      ),
    );
  }
}
