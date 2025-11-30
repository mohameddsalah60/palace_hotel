import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';

import '../../../../../core/widgets/stat_overview_card.dart';
import '../../cubits/reports_dashboard_cubit.dart';

class RepoertsMoneyStates extends StatelessWidget {
  const RepoertsMoneyStates({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.handshake_outlined,
            title: "إجمالي الدفع كاش",
            value:
                "${context.read<ReportsDashboardCubit>().getTotalByPaymentMethod(bookings: context.read<BookingRoomCubit>().allBookings, paymentType: 'كاش')} ج.م",
            subtitle: "هذا الشهر",
            isIncrease: true,
            colorCard: AppColors.darkBlue,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.calendar_month_rounded,
            title: "إجمالي التحويلات البنكية",
            value:
                "${context.read<ReportsDashboardCubit>().getTotalByPaymentMethod(bookings: context.read<BookingRoomCubit>().allBookings, paymentType: 'تحويل بنكى')} ج.م",
            subtitle: "هذا الشهر",
            isIncrease: true,
            colorCard: AppColors.warning,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.wallet_rounded,
            title: 'إجمالي المحافظ الإلكترونية',
            value:
                "${context.read<ReportsDashboardCubit>().getTotalByPaymentMethod(bookings: context.read<BookingRoomCubit>().allBookings, paymentType: 'Wallet')} ج.م",
            subtitle: "هذا الشهر",
            isIncrease: true,
            colorCard: AppColors.green,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.mobile_friendly,
            title: "إجمالي انستا باي",
            value:
                "${context.read<ReportsDashboardCubit>().getTotalByPaymentMethod(bookings: context.read<BookingRoomCubit>().allBookings, paymentType: 'إنستا باي')} ج.م",
            subtitle: "هذا الشهر",
            isIncrease: true,
            colorCard: AppColors.mainBlue,
          ),
        ),
        SizedBox(width: 16.w),

        Expanded(
          child: StatOverviewCard(
            icon: Icons.show_chart,
            title: 'إجمالي الإيرادات',
            value:
                "${context.read<ReportsDashboardCubit>().getTotalByPaymentMethod(bookings: context.read<BookingRoomCubit>().allBookings)} ج.م",

            subtitle: "هذا الشهر",
            isIncrease: true,
            colorCard: AppColors.penaltyRedLight,
          ),
        ),
        SizedBox(width: 16.w),
      ],
    );
  }
}
