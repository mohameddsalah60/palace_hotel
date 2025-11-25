import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/routing/app_routes.dart';
import 'package:palace_systeam_managment/core/widgets/custom_alert_dialog.dart';
import 'package:palace_systeam_managment/core/widgets/custom_loading_alert.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';
import 'package:palace_systeam_managment/features/home/presentation/cubits/page_changed_cubit.dart';
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
          SizedBox(height: 88.h),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        customAlertDialog(
          context,
          'هل انت متاكد من تسجيل الخروج؟',
          'يرجى التاكيد',
          AppColors.warning,
          () {
            context.read<PageChangedCubit>().logout();
          },
        );
      },
      child: DrawerItem(
        color: AppColors.red,
        drawerItemEntity: DrawerItemEntity(
          title: 'تسجيل خروج',
          icon: Icons.logout_rounded,
        ),
      ),
    );
  }
}
