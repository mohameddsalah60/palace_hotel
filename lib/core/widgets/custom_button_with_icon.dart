import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? radius;

  const CustomButtonWithIcon({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.backgroundColor,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? AppColors.mainBlue;

    // لو اللون أبيض → اعمل Border رمادي
    final bool isWhite = bg == Colors.white || bg == AppColors.wheit;

    return SizedBox(
      height: height ?? 48.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(bg),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16.w),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 12.r),
              side:
                  isWhite
                      ? BorderSide(color: AppColors.grey, width: .8)
                      : BorderSide.none,
            ),
          ),
          elevation: WidgetStateProperty.all(isWhite ? 0 : 2),
          textStyle: WidgetStateProperty.all(
            AppTextStyles.fontWeight600Size16(context),
          ),
        ),

        onPressed: onPressed,
        child:
            icon == null
                ? Text(
                  text,
                  style: AppTextStyles.fontWeight600Size16(context).copyWith(
                    color: isWhite ? AppColors.black : AppColors.wheit,
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(
                      icon,
                      color: isWhite ? AppColors.black : AppColors.wheit,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      text,
                      style: AppTextStyles.fontWeight600Size16(
                        context,
                      ).copyWith(
                        color: isWhite ? AppColors.black : AppColors.wheit,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
