import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';

class CustomAppbarHeaderWidget extends StatelessWidget {
  const CustomAppbarHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions,
  });
  final String title, subtitle;
  final Widget? actions;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: AppColors.wheit,
        border: Border(
          bottom: BorderSide(color: AppColors.greyCheckBox, width: .3),
        ),
      ),
      padding: EdgeInsets.all(16.r),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: AppTextStyles.fontWeight700Size24(context)),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Text(
            subtitle,
            style: AppTextStyles.fontWeight500Size16(context),
          ),
        ),
        trailing: actions,
      ),
    );
  }
}
