import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class RoomItemPriceAndNumperRoom extends StatelessWidget {
  const RoomItemPriceAndNumperRoom({super.key, required this.roomEntity});
  final RoomEntity roomEntity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${roomEntity.pricePerNight} ج.م",
          style: AppTextStyles.fontWeight700Size24(
            context,
          ).copyWith(color: AppColors.mainBlue),
        ),
        Row(
          children: [
            Text(
              roomEntity.roomId.toString(),
              style: AppTextStyles.fontWeight700Size24(
                context,
              ).copyWith(color: AppColors.black),
            ),
            SizedBox(width: 8.w),

            Icon(Icons.bed_outlined, size: 32.r),
          ],
        ),
      ],
    );
  }
}
