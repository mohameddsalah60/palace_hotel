import 'package:flutter/material.dart';

import 'app_colors.dart';

// The helper function to calculate the responsive font size
double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * fontSize;
  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

// Helper function to get the scale factor for desktop
double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;

  return width / 1800;
}

// Your AppTextStyles class, modified to be responsive
abstract class AppTextStyles {
  static TextStyle fontWeight700Size32(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 32),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle fontWeight700Size24(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontWeight: FontWeight.w700,
      color: AppColors.mainBlue,
    );
  }

  static TextStyle fontWeight700Size16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    );
  }

  static TextStyle fontWeight700Size20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    );
  }

  static TextStyle fontWeight500Size14(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w500,
      color: AppColors.textFieldSecondary,
    );
  }

  static TextStyle fontWeight400Size12(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle fontWeight400Size14(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
    );
  }

  static TextStyle fontWeight600Size16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w600,
    );
  }
}
