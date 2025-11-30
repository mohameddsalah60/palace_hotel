import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';

class StatOverviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final bool isIncrease;
  final Color colorCard;
  const StatOverviewCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.colorCard,
    this.isIncrease = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(right: BorderSide(color: colorCard, width: 4.w)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // نسبة %
          SizedBox(height: 12.h),

          // الأيقونة
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colorCard.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 28.sp, color: colorCard),
          ),
          SizedBox(height: 16.h),

          // العنوان
          Text(
            title,
            style: AppTextStyles.fontWeight500Size16(
              context,
            ).copyWith(color: AppColors.black),
          ),
          SizedBox(height: 6.h),

          // الرقم
          Text(
            value,
            style: AppTextStyles.fontWeight700Size24(
              context,
            ).copyWith(color: AppColors.black),
          ),
          SizedBox(height: 6.h),

          // الوصف
          Text(
            subtitle,
            style: AppTextStyles.fontWeight400Size14(
              context,
            ).copyWith(color: AppColors.grey),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
