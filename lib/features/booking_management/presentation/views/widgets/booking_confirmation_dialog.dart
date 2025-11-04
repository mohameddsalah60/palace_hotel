import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import 'booking_confirmation_body.dart';

class BookingConfirmationDialog extends StatelessWidget {
  const BookingConfirmationDialog({super.key, required this.booking});

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<BookingRoomCubit>()),
        BlocProvider(create: (context) => getIt<RoomsCubit>()),
      ],
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 5,
        child: Container(
          width: 600.w,
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: AppColors.wheit,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: BookingConfirmationBody(booking: booking),
        ),
      ),
    );
  }
}
