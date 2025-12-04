import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubit/employee_cubit.dart';
import '../../cubit/employee_state.dart';
import 'employees_data_table.dart';

class EmployeesBlocConsumer extends StatelessWidget {
  const EmployeesBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeError) {
          customAlertDialog(context, state.message, 'error', AppColors.red, () {
            Navigator.pop(context);
          });
        } else if (state is EmployeeSuccess) {
          customSnackBar(
            context: context,
            message: 'تم الحذف بنجاح',
            color: AppColors.success,
          );
        }
      },
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.mainBlue),
          );
        } else if (state is EmployeeLoaded) {
          return EmployeesDataTable(employees: state.employees);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
