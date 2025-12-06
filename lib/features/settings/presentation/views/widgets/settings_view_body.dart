import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_appbar_header_widget.dart';
import '../../../../../core/widgets/custom_button_with_icon.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubits/change_password_cubit.dart';
import 'password_tile_field.dart';
import 'settings_sidebar.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppbarHeaderWidget(
          title: 'الاعدادات',
          subtitle: 'يمكنك هنا التعديل علي الحساب الخاص بك',
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsSidebar(),
              SizedBox(width: 24.w),
              Container(
                width: 500.w,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordSuccess) {
                      customSnackBar(
                        context: context,
                        message: "تم تغيير كلمة المرور بنجاح",
                        color: AppColors.green,
                      );
                    } else if (state is ChangePasswordError) {
                      customSnackBar(
                        context: context,
                        message: state.error,
                        color: AppColors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: context.read<ChangePasswordCubit>().formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تغيير كلمة المرور',
                            style: AppTextStyles.fontWeight700Size20(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "تحديث كلمة المرور الخاصة بحسابك",
                            style: AppTextStyles.fontWeight400Size14(context),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Divider(
                              color: AppColors.greyCheckBox,
                              thickness: .5,
                            ),
                          ),

                          /// Old Password
                          PasswordTileField(
                            title: "كلمة المرور القديمة",
                            controller:
                                context
                                    .read<ChangePasswordCubit>()
                                    .oldController,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "ادخل كلمة المرور القديمة";
                              }
                              if (v.length < 6) {
                                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),

                          /// New Password
                          PasswordTileField(
                            title: "كلمة المرور الجديدة",
                            controller:
                                context
                                    .read<ChangePasswordCubit>()
                                    .newController,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "ادخل كلمة المرور الجديدة";
                              }
                              if (v.length < 6) {
                                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),

                          /// Confirm New Password
                          PasswordTileField(
                            title: "تأكيد كلمة المرور الجديدة",
                            controller:
                                context
                                    .read<ChangePasswordCubit>()
                                    .confirmController,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "أكد كلمة المرور الجديدة";
                              }
                              if (v !=
                                  context
                                      .read<ChangePasswordCubit>()
                                      .newController
                                      .text) {
                                return "كلمة المرور غير متطابقة";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),

                          state is ChangePasswordLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButtonWithIcon(
                                text: 'حفظ التغييرات',
                                icon: Icons.save_outlined,
                                onPressed: () {
                                  if (context
                                      .read<ChangePasswordCubit>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    context
                                        .read<ChangePasswordCubit>()
                                        .changePassword(
                                          oldPassword:
                                              context
                                                  .read<ChangePasswordCubit>()
                                                  .oldController
                                                  .text,
                                          newPassword:
                                              context
                                                  .read<ChangePasswordCubit>()
                                                  .newController
                                                  .text,
                                        );
                                  }
                                },
                              ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
