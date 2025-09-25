import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class RoomItemInfoRow extends StatelessWidget {
  const RoomItemInfoRow({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.blackLight, size: 24.r),
        SizedBox(width: 8.w),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.fontWeight600Size16(
            context,
          ).copyWith(color: AppColors.blackLight),
        ),
      ],
    );
  }
}
