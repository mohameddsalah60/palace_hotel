import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import 'forget_password_dialog.dart';

class ForgetPassowordLabel extends StatelessWidget {
  const ForgetPassowordLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          showResetPasswordDialog(context);
        },
        child: Text(
          'هل نسيت كلمة المرور ؟',
          style: AppTextStyles.fontWeight500Size14(
            context,
          ).copyWith(color: AppColors.blackLight),
        ),
      ),
    );
  }
}
