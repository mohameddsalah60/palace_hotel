import 'package:flutter/material.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';

import 'widgets/new_room_form_dialog.dart';
import 'widgets/rooms_view_body.dart';
import '../../../../core/widgets/custom_floating_action_button.dart';

class RoomsView extends StatelessWidget {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      floatingActionButton: CustomFloatingActionButton(
        child: NewRoomFormDialog(),
      ),
      body: RoomsViewBody(),
    );
  }
}
