import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/routing/app_routes.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_loading_alert.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubits/sign_in_cubit.dart';

class SignInBlocListener extends StatelessWidget {
  const SignInBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          customLoadingAlert(context);
        } else if (state is SignInFailure) {
          Navigator.pop(context);
          customSnackBar(
            context: context,
            message: state.message,
            color: AppColors.red,
          );
        } else {
          Navigator.pop(context);

          customSnackBar(
            context: context,
            message: 'تم تسجيل الدخول بنجاح',
            color: AppColors.success,
          );
          Navigator.pushReplacementNamed(context, AppRoutes.mainView);
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
