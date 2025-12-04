import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_appbar_header_widget.dart';
import '../../domain/repositories/employee_repo.dart';
import '../cubit/employee_cubit.dart';
import 'widgets/employees_bloc_consumer.dart';
import 'widgets/employees_serach_bar.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => EmployeeCubit(getIt<EmployeeRepo>())..fetchEmployees(),
      child: Scaffold(
        backgroundColor: AppColors.wheitDark,
        body: Column(
          children: [
            CustomAppbarHeaderWidget(
              title: 'إدارة الموظفين',
              subtitle: 'عرض وإدارة بيانات جميع الموظفين في الفندق',
            ),

            SizedBox(height: 24.h),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                color: AppColors.wheit,
              ),
              padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 16.r),
              margin: EdgeInsets.symmetric(horizontal: 32.r),
              child: Column(
                children: [
                  EmployeesSerachBar(),
                  SizedBox(height: 24.h),

                  EmployeesBlocConsumer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
