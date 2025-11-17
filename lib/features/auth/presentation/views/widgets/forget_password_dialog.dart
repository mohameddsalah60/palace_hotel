import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/widgets/custom_button.dart';
import 'package:palace_systeam_managment/core/widgets/custom_loading_alert.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/core/widgets/custom_text_from_field.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';
import 'package:palace_systeam_managment/features/auth/presentation/cubits/forget_password_cubit.dart';

Future<void> showResetPasswordDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.backgroundScaffold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.r, vertical: 24.r),
        child: BlocProvider(
          create: (context) => ForgetPasswordCubit(getIt<AuthRepo>()),
          child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordLoading) {
                customLoadingAlert(context);
              } else if (state is ForgetPasswordFailure) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                customSnackBar(
                  context: context,
                  message: state.message,
                  color: AppColors.red,
                );
              } else if (state is ForgetPasswordSuccess) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                customSnackBar(
                  context: context,
                  message:
                      'تم ارسال رابط اعادة تعيين كلمة المرور الى بريدك الالكترونى',
                  color: AppColors.success,
                );
              }
            },
            child: ShowResetPasswordBody(),
          ),
        ),
      );
    },
  );
}

class ShowResetPasswordBody extends StatelessWidget {
  const ShowResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.w,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: context.read<ForgetPasswordCubit>().formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: .15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_reset,
                  size: 38,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                "إعادة تعيين كلمة المرور",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),

              SizedBox(height: 8.h),

              Text(
                "اكتب البريد الإلكتروني المسجّل، وهنبعتلك لينك لإعادة ضبط كلمة المرور.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              SizedBox(height: 34.h),

              // Email Field
              CustomTextFromField(
                controller: context.read<ForgetPasswordCubit>().emailController,
                labelText: 'البريد الالكترونى',
                icon: Icons.email_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ادخال بريد الكترونى';
                  } else if (!value.contains('@')) {
                    return 'يجب ادخال بريد الكترونى صحيح';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.h),

              CustomButton(
                text: 'ارسال',
                onPressed: () {
                  if (context
                      .read<ForgetPasswordCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    context
                        .read<ForgetPasswordCubit>()
                        .sendPasswordResetEmail();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
