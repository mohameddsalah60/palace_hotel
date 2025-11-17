import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';

import '../../../../../core/utils/app_images.dart';
import 'forget_passoword_label.dart';
import 'sign_in_bloc_listener.dart';
import 'sign_in_button.dart';
import 'sign_in_form.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 500.w,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.wheit,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    height: 180.h,
                    width: 250.w,
                  ),
                ),
                Text(
                  'تسجيل الدخول',
                  style: AppTextStyles.fontWeight600Size20(
                    context,
                  ).copyWith(color: AppColors.blackLight),
                ),
                SizedBox(height: 16.h),
                SignInForm(),
                SizedBox(height: 16.h),
                ForgetPassowordLabel(),
                SizedBox(height: 24.h),
                SignInButton(),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'version 1.0',
                    style: AppTextStyles.fontWeight500Size14(
                      context,
                    ).copyWith(color: AppColors.greyCheckBox),
                  ),
                ),
                SizedBox(height: 8.h),
                SignInBlocListener(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
