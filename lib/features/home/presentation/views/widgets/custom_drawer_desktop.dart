import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import 'drawer_list_view.dart';

class CustomDrawerDesktop extends StatelessWidget {
  const CustomDrawerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        color: AppColors.wheit,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Center(
              child: Image.asset(
                AppImages.appLogo,
                height: 200.h,
                width: 300.w,
              ),
            ),
            SizedBox(height: 16.h),
            DrawerListView(),
          ],
        ),
      ),
    );
  }
}
