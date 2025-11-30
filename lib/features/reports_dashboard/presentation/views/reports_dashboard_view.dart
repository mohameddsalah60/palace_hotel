import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/widgets/custom_button_with_icon.dart';
import '../../../../core/di/getit_service_loacator.dart';
import '../../../../core/widgets/custom_appbar_header_widget.dart';
import '../../../booking_management/presentation/cubits/booking_room_cubit.dart';
import '../cubits/reports_dashboard_cubit.dart';
import 'widgets/last_money_transactions.dart';
import 'widgets/repoerts_money_states.dart';

class ReportsDashboardView extends StatelessWidget {
  const ReportsDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsDashboardCubit(),
      child: Scaffold(
        backgroundColor: AppColors.wheitDark,
        body: BlocProvider.value(
          value: getIt<BookingRoomCubit>(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbarHeaderWidget(
                  title: 'التقارير المالية',
                  subtitle: 'تحليل شامل للإيرادات والمصروفات حسب طرق الدفع',
                  actions: CustomButtonWithIcon(
                    text: 'تحديث البيانات',
                    icon: Icons.refresh,
                  ),
                ),
                SizedBox(height: 28.h),
                RepoertsMoneyStates(),
                SizedBox(height: 28.h),
                LastMoneyTransactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
