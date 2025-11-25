import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/entites/user_entity.dart';
import 'package:palace_systeam_managment/features/employee_management/domain/repositories/employee_repo.dart';
import 'package:palace_systeam_managment/features/employee_management/presentation/cubit/add_new_employee_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../../core/widgets/custom_loading_alert.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import 'permission_dialog_body.dart';

Future<void> showPermissionsDialog(
  BuildContext context,
  UserEntity user,
) async {
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
                message: 'تم تعديل صلاحيات الموظف بنجاح',
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
              child: PermissionsDialogBody(user: user),
            ),
          ),
        ),
      );
    },
  );
}
