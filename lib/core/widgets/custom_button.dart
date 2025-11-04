import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    required this.text,
  });
  final void Function()? onPressed;
  final Color? backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ?? AppColors.mainBlue,
          ),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 20.h),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.fontWeight700Size16(
            context,
          ).copyWith(color: AppColors.wheit),
        ),
      ),
    );
  }
}
