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
  });
  final DrawerItemEntity drawerItemEntity;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(vertical: 4.r, horizontal: 8.r),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.lightBlue : AppColors.wheit,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            drawerItemEntity.icon,
            color: isSelected ? AppColors.darkBlue : AppColors.grey,
            size: 24.sp,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              drawerItemEntity.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTextStyles.fontWeight600Size16.copyWith(
                color: isSelected ? AppColors.darkBlue : AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
