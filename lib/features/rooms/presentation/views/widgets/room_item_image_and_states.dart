import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';

class RoomItemImageAndStates extends StatelessWidget {
  const RoomItemImageAndStates({super.key, required this.roomEntity});
  final RoomEntity roomEntity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
          child: Image.asset(
            AppImages.room,
            height: 180.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        PositionedDirectional(
          top: 10.h,
          end: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: roomEntity.roomStatusColor(roomEntity.statusRoom),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Text(
              roomEntity.statusRoom,
              style: AppTextStyles.fontWeight600Size16(
                context,
              ).copyWith(color: AppColors.wheit),
            ),
          ),
        ),
      ],
    );
  }
}
