import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';
import 'package:palace_systeam_managment/core/widgets/custom_alert_dialog.dart';
import 'package:palace_systeam_managment/core/widgets/custom_loading_alert.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/employee_management/domain/repositories/employee_repo.dart';
import 'package:palace_systeam_managment/features/employee_management/presentation/cubit/add_new_employee_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import 'add_employee_form.dart';
import 'add_new_employee_action.dart';
import 'permission_switcher.dart';

Future<void> showAddEmployeeDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider(
        create: (context) => AddNewEmployeeCubit(getIt<EmployeeRepo>()),
        child: BlocListener<AddNewEmployeeCubit, AddNewEmployeeState>(
          listener: (context, state) {
            if (state is AddNewEmployeeFailure) {
              Navigator.pop(context);

              customAlertDialog(
                context,
                state.message,
                'error',
                AppColors.red,
                () {
                  Navigator.pop(context);
                },
              );
            } else if (state is AddNewEmployeeSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);

              customSnackBar(
                context: context,
                message: 'تم إضافة الموظف بنجاح',
                color: AppColors.success,
              );
            } else if (state is AddNewEmployeeLoading) {
              customLoadingAlert(context);
            }
          },
          child: Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.wheit,
              ),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.35,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "إضافة موظف جديد",
                          style: AppTextStyles.fontWeight700Size20(context),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 34.r,
                            color: AppColors.greyCheckBox,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    AddEmployeeForm(),
                    SizedBox(height: 20),

                    Text(
                      "الصلاحيات",
                      style: AppTextStyles.fontWeight700Size20(context),
                    ),
                    SizedBox(height: 12),

                    PermissionSwitcher(),

                    SizedBox(height: 20),

                    AddNewEmployeeAction(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
