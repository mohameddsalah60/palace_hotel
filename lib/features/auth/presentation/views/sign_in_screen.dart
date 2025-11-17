import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';
import 'package:palace_systeam_managment/features/auth/presentation/cubits/sign_in_cubit.dart';

import '../../../../core/di/getit_service_loacator.dart';
import 'widgets/sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt<AuthRepo>()),
      child: Scaffold(backgroundColor: AppColors.wheitDark, body: SignInBody()),
    );
  }
}
