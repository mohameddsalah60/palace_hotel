import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle fontWeight700Size32 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle fontWeight700Size24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.mainBlue,
  );
  static TextStyle fontWeight700Size16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static TextStyle fontWeight500Size14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textFieldSecondary,
  );
  static TextStyle fontWeight400Size12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle fontWeight400Size14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static TextStyle fontWeight600Size16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
}

double getResponsiveFontSize({required double fontSize}) {
  double scaleFactor = 1800;
  double responsiveFontSize = scaleFactor * fontSize;
  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}
