import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.onChanged,
    required this.hintText,
  });

  final void Function(String p1)? onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: AppTextStyles.fontWeight400Size14(
        context,
      ).copyWith(color: AppColors.blackLight, fontSize: 18.sp),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        fillColor: AppColors.greyBorder,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        suffixIcon: Icon(Icons.search, color: AppColors.blackLight),
      ),
    );
  }
}
