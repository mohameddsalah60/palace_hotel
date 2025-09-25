import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';

customSnackBar({
  required BuildContext context,
  required String message,
  Color color = Colors.red,
}) {
  // Custom SnackBar widget
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.symmetric(horizontal: 700.r),
      content: Center(
        child: Text(
          message,
          style: AppTextStyles.fontWeight700Size16(
            context,
          ).copyWith(color: AppColors.wheit),
        ),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 6),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

  // Custom SnackBar widget

