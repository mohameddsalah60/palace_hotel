import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/home/presentation/views/widgets/drawer_item.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../domin/entites/drawer_item_entity.dart';
import 'drawer_list_view.dart';

class CustomDrawerDesktop extends StatelessWidget {
  const CustomDrawerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      color: AppColors.wheit,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Center(
            child: Image.asset(AppImages.appLogo, height: 200.h, width: 300.w),
          ),
          DrawerListView(),
          DrawerItem(
            color: AppColors.red,
            drawerItemEntity: DrawerItemEntity(
              title: 'تسجيل خروج',
              icon: Icons.logout_rounded,
            ),
          ),
          SizedBox(height: 88.h),
        ],
      ),
    );
  }
}
