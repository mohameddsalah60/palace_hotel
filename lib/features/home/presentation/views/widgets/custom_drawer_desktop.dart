import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/routing/app_routes.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';
import 'package:palace_systeam_managment/core/widgets/custom_alert_dialog.dart';
import 'package:palace_systeam_managment/core/widgets/custom_loading_alert.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';
import 'package:palace_systeam_managment/features/home/presentation/cubits/page_changed_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import 'drawer_list_view.dart';
import 'logout_button.dart';

class CustomDrawerDesktop extends StatelessWidget {
  const CustomDrawerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      color: AppColors.darkbblue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 80.w,
                  height: 65.h,
                  padding: EdgeInsets.only(top: 8.r),
                  decoration: BoxDecoration(
                    color: AppColors.wheit,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Image.asset(AppImages.appLogo, fit: BoxFit.cover),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'فندق بالاس',
                      style: AppTextStyles.fontWeight700Size20(
                        context,
                      ).copyWith(color: AppColors.wheit),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'نظام الادارة',
                      style: AppTextStyles.fontWeight400Size14(
                        context,
                      ).copyWith(color: AppColors.greyCheckBox),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.blue, thickness: .5),
          SizedBox(height: 16.h),

          DrawerListView(),
          SizedBox(height: 16.h),

          Spacer(),
          Divider(color: AppColors.blue, thickness: .5),
          SizedBox(height: 16.h),

          BlocProvider(
            create: (context) => PageChangedCubit(getIt<AuthRepo>()),
            child: BlocListener<PageChangedCubit, PageChangedState>(
              listener: (context, state) {
                if (state is PageChangedLogoutFailure) {
                  Navigator.pop(context);

                  customAlertDialog(
                    context,
                    state.message,
                    'error',
                    AppColors.red,
                    () {
                      Navigator.pop(context);
                    },
                  );
                } else if (state is PageChangedLogoutSuccess) {
                  Navigator.pushReplacementNamed(context, AppRoutes.signInView);
                } else {
                  customLoadingAlert(context);
                }
              },
              child: LogoutButton(),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
