import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class RoomItemDescreption extends StatelessWidget {
  const RoomItemDescreption({super.key, required this.roomEntity});
  final RoomEntity roomEntity;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الدور ${roomEntity.floorRoom} - ${roomEntity.typeRoom} - ${roomEntity.descriptionRoom}',
          style: AppTextStyles.fontWeight500Size16(
            context,
          ).copyWith(color: AppColors.black, fontSize: 16.sp),
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'أشخاص',
              style: AppTextStyles.fontWeight400Size14(
                context,
              ).copyWith(color: AppColors.black),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.people, color: AppColors.black, size: 20.r),

            SizedBox(width: 16.w),
            Text(
              'سرير آو اكثر',
              style: AppTextStyles.fontWeight400Size14(
                context,
              ).copyWith(color: AppColors.black),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.king_bed, color: AppColors.black, size: 20.r),
          ],
        ),
        SizedBox(height: 12.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.wifi, color: AppColors.black, size: 20.r),
            SizedBox(width: 12.w),
            Icon(Icons.tv, color: AppColors.black, size: 20.r),
            SizedBox(width: 12.w),
            Icon(Icons.ac_unit, color: AppColors.black, size: 20.r), // تكييف
            SizedBox(width: 12.w),
            Icon(Icons.shower, color: AppColors.black, size: 20.r), // دش/حمام
            SizedBox(width: 12.w),
            Icon(Icons.local_cafe, color: AppColors.black, size: 20.r), // قهوة
          ],
        ),
      ],
    );
  }
}
