import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/stat_overview_card.dart';

class BookingStatus extends StatelessWidget {
  const BookingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.list_alt,
            title: 'جميع الحجوزات',
            value:
                context.read<BookingRoomCubit>().allBookings.length.toString(),
            subtitle: 'حجز',
            colorCard: AppColors.mainBlue,
          ),
        ),
        SizedBox(width: 16.w),

        Expanded(
          child: StatOverviewCard(
            icon: Icons.beenhere_rounded,
            title: 'الحجوزات المكتملة',
            value:
                context
                    .watch<BookingRoomCubit>()
                    .allBookings
                    .where((b) => b.stutasBooking == 'مكتمل')
                    .length
                    .toString(),
            subtitle: 'حجز',
            colorCard: AppColors.green,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.hourglass_bottom,
            title: 'الحجوزات النشطة',
            value:
                context
                    .watch<BookingRoomCubit>()
                    .allBookings
                    .where((b) => b.stutasBooking == 'نشط')
                    .length
                    .toString(),
            subtitle: 'حجز',
            colorCard: AppColors.warning,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.cancel,
            title: 'الحجوزات الملغية',
            value:
                context
                    .watch<BookingRoomCubit>()
                    .allBookings
                    .where((b) => b.stutasBooking == 'ملغي')
                    .length
                    .toString(),
            subtitle: 'حجز',
            colorCard: AppColors.red,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: StatOverviewCard(
            icon: Icons.event_note,
            title: 'الحجوزات القادمة',
            value:
                context
                    .watch<BookingRoomCubit>()
                    .allBookings
                    .where((b) => b.checkInDate.isAfter(DateTime.now()))
                    .length
                    .toString(),
            subtitle: 'حجز',
            colorCard: Colors.lightBlue,
          ),
        ),
        SizedBox(width: 16.w),
      ],
    );
  }
}
