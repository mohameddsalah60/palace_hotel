import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/helpers/get_user.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/room_item_image_and_states.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../cubits/rooms_cubit.dart';
import 'booking_room_dialog.dart';
import 'extend_the_stay_dilog.dart';
import 'new_room_form_dialog.dart';
import 'room_item_descreption.dart';
import 'room_item_price_and_numper_room.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key, required this.roomEntity});
  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyCheckBox.withValues(alpha: .3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoomItemImageAndStates(roomEntity: roomEntity),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoomItemPriceAndNumperRoom(roomEntity: roomEntity),
                SizedBox(height: 8.h),
                RoomItemDescreption(roomEntity: roomEntity),
                SizedBox(height: 16.h),
                _buildActionButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (roomEntity.statusRoom == 'محجوز') {
      showDialog(
        context: context,
        builder: (context) => ExtendTheStayDialog(roomEntity: roomEntity),
      );
    } else if (roomEntity.statusRoom == 'تحت الصيانة' ||
        roomEntity.statusRoom == 'هاوس') {
      if (getUser().permissions.canEditRoom) {
        showDialog(
          context: context,
          builder: (context) => NewRoomFormDialog(roomEntity: roomEntity),
        ).then((_) {
          if (context.mounted) {
            context.read<RoomsCubit>().formController.clear();
          }
        });
      } else {
        customSnackBar(context: context, message: 'عفوأ لا تمتلك الصلاحية');
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => BookingRoomDialog(roomEntity: roomEntity),
      );
    }
  }

  Widget _buildActionButton(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.greyCheckBox, width: 1.w),
          ),
          child: InkWell(
            onTap: () {
              if (getUser().permissions.canEditRoom) {
                showDialog(
                  context: context,
                  builder:
                      (context) => NewRoomFormDialog(roomEntity: roomEntity),
                ).then((_) {
                  if (context.mounted) {
                    context.read<RoomsCubit>().formController.clear();
                  }
                });
              } else {
                customSnackBar(
                  context: context,
                  message: 'عفوأ لا تمتلك الصلاحية',
                );
              }
            },
            child: Icon(Icons.edit_outlined, color: AppColors.black),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleTap(context),

            style: ElevatedButton.styleFrom(
              backgroundColor: roomEntity.roomStatusColor(
                roomEntity.statusRoom,
              ),
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 0,
            ),
            child: Text(
              roomEntity.roomStatusText(roomEntity.statusRoom),
              style: AppTextStyles.fontWeight600Size16(
                context,
              ).copyWith(color: AppColors.wheit, fontSize: 18.sp),
            ),
          ),
        ),
      ],
    );
  }
}
