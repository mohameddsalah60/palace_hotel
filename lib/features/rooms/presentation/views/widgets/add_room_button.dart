import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/get_user.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button_with_icon.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubits/rooms_cubit.dart';
import 'new_room_form_dialog.dart';

class AddRoomButton extends StatelessWidget {
  const AddRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButtonWithIcon(
      text: 'اضافة غرفة جديدة',
      icon: Icons.add_circle_outline_sharp,
      onPressed: () {
        if (getUser().permissions.canAddRoom) {
          showDialog(
            context: context,
            builder: (context) => NewRoomFormDialog(),
          ).then((_) {
            if (context.mounted) {
              context.read<RoomsCubit>().formController.clear();
            }
          });
        } else {
          customSnackBar(
            context: context,
            message: 'عفوأ لا تمتك الصلاحية',
            color: AppColors.red,
          );
        }
      },
    );
  }
}
