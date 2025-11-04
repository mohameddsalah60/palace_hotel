import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_date_field.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';

class StartAndEndBookingField extends StatelessWidget {
  const StartAndEndBookingField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomDateTimeFormField(
            labelText: 'تاريخ الدخول',
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            initialDate:
                context.read<BookingRoomCubit>().selectedCheckInDate ??
                DateTime.now(),
            suffixIcon: Icons.calendar_today,
            onChanged: (date) {
              context.read<BookingRoomCubit>().updateCheckInDate(date!);
            },
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomDateTimeFormField(
            labelText: 'تاريخ الخروج',
            firstDate:
                context.read<BookingRoomCubit>().selectedCheckInDate ??
                DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            initialDate:
                context.read<BookingRoomCubit>().selectedCheckOutDate ??
                context.read<BookingRoomCubit>().selectedCheckInDate?.add(
                  const Duration(days: 1),
                ) ??
                DateTime.now().add(const Duration(days: 1)),
            suffixIcon: Icons.calendar_today,
            onChanged: (date) {
              context.read<BookingRoomCubit>().updateCheckOutDate(date!);
            },
          ),
        ),
      ],
    );
  }
}
