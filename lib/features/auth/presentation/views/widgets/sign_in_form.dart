import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/auth/presentation/cubits/sign_in_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignInCubit>().formKey,
      child: Column(
        children: [
          CustomTextFromField(
            controller: context.read<SignInCubit>().email,
            labelText: 'البريد الالكترونى',
            icon: Icons.person,
            textColor: AppColors.greyDark,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب ادخال بريد الكترونى';
              } else if (!value.contains('@')) {
                return 'يجب ادخال بريد الكترونى صحيح';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextFromField(
            isObscureText: true,
            controller: context.read<SignInCubit>().password,
            labelText: 'كلمة المرور',
            icon: Icons.password,
            textColor: AppColors.greyDark,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب ادخال كلمة المرور';
              } else if (value.length <= 5) {
                return 'يجب ادخال كلمة المرور اكتر من ٦ حروف او ارقام';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
