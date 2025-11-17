import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/auth/presentation/cubits/sign_in_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'تسجيل الدخول',
      backgroundColor: AppColors.mainBlue,
      onPressed: () {
        if (context.read<SignInCubit>().formKey.currentState!.validate()) {
          context.read<SignInCubit>().signInWithEmailAndPassword();
        }
      },
    );
  }
}
