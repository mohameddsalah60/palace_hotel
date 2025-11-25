import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/widgets/custom_alert_dialog.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/employee_management/presentation/cubit/employee_state.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/repositories/employee_repo.dart';
import '../cubit/employee_cubit.dart';
import 'widgets/employees_data_table.dart';
import 'widgets/employees_view_header.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => EmployeeCubit(getIt<EmployeeRepo>())..fetchEmployees(),
      child: Scaffold(
        backgroundColor: AppColors.wheitDark,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 24.r),
          child: Column(
            children: [
              EmployeesViewHeader(),
              SizedBox(height: 24.h),
              BlocConsumer<EmployeeCubit, EmployeeState>(
                listener: (context, state) {
                  if (state is EmployeeError) {
                    customAlertDialog(
                      context,
                      state.message,
                      'error',
                      AppColors.red,
                      () {
                        Navigator.pop(context);
                      },
                    );
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
                      child: CircularProgressIndicator(
                        color: AppColors.mainBlue,
                      ),
                    );
                  } else if (state is EmployeeLoaded) {
                    return EmployeesDataTable(employees: state.employees);
                  } else {
                    return SizedBox.shrink();
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
