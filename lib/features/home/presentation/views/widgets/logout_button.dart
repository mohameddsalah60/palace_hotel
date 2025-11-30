import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/get_user.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_alert_dialog.dart';
import '../../cubits/page_changed_cubit.dart';

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
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Image.asset(AppImages.profile, height: 80.h, width: 85.w),
        title: Text(
          getUser().name,
          style: AppTextStyles.fontWeight600Size16(
            context,
          ).copyWith(color: AppColors.wheit),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          getUser().jopTitle,
          style: AppTextStyles.fontWeight400Size14(
            context,
          ).copyWith(color: AppColors.greyCheckBox),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Padding(
          padding: EdgeInsets.only(left: 16.r),
          child: Icon(
            Icons.logout_outlined,
            color: AppColors.greyBorder,
            size: 30.sp,
          ),
        ),
      ),
    );
  }
}
