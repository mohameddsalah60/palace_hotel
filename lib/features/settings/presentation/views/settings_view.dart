import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/getit_service_loacator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domin/repo/change_password_repo.dart';
import '../cubits/change_password_cubit.dart';
import 'widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      body: BlocProvider(
        create: (_) => ChangePasswordCubit(getIt<ChangePasswordRepo>()),
        child: SettingsViewBody(),
      ),
    );
  }
}
