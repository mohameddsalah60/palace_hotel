import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../domin/entites/drawer_item_entity.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.drawerItemEntity,
    this.isSelected = false,
    this.color,
  });
  final DrawerItemEntity drawerItemEntity;
  final bool isSelected;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(vertical: 4.r, horizontal: 8.r),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue : AppColors.darkbblue,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ]
                : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(drawerItemEntity.icon, color: AppColors.wheit, size: 24.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              drawerItemEntity.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTextStyles.fontWeight600Size16(
                context,
              ).copyWith(color: AppColors.wheit),
            ),
          ),
        ],
      ),
    );
  }
}
