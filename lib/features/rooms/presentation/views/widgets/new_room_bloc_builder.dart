import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import '../../../../../core/utils/app_text_styles.dart';
import 'new_room_from_body.dart';

class NewrRoomBlocBuilder extends StatelessWidget {
  const NewrRoomBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomsCubit, RoomsState>(
      listener: (context, state) {
        if (state is RoomsFailure) {
          customSnackBar(context: context, message: state.errMessage);
        }
      },
      child: AlertDialog(
        backgroundColor: AppColors.wheit,
        title: Text(
          'إضافة/تعديل غرفة جديدة',
          textAlign: TextAlign.start,
          style: AppTextStyles.fontWeight700Size16(
            context,
          ).copyWith(color: AppColors.blackLight, fontSize: 20.sp),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        elevation: 10,
        content: NewRoomBody(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'إلغاء',
              style: AppTextStyles.fontWeight600Size16(
                context,
              ).copyWith(color: AppColors.greyDark),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (context.read<RoomsCubit>().formKey.currentState!.validate()) {
                context.read<RoomsCubit>().addNewRoom();
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'حفظ',
              style: AppTextStyles.fontWeight700Size16(
                context,
              ).copyWith(color: AppColors.wheit),
            ),
          ),
        ],
      ),
    );
  }
}
