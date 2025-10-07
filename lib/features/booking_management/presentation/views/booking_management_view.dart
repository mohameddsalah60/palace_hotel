import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/booking_room_cubit.dart';

import 'widgets/booking_data_table.dart';
import 'widgets/booking_header.dart';

class BookingManagementView extends StatelessWidget {
  const BookingManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      body: BlocProvider.value(
        value: getIt<BookingRoomCubit>()..getBookings(),
        child: BookingManagementBody(),
      ),
    );
  }
}

class BookingManagementBody extends StatelessWidget {
  const BookingManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 24.r),
        child: Column(
          children: [
            BookingHeader(),
            SizedBox(height: 24.h),
            BlocConsumer<BookingRoomCubit, BookingRoomState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is BookingRoomLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BookingRoomError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is BookingGetDataSuccess) {
                  if (state.bookings.isEmpty) {
                    return Center(child: Text('لا توجد حجوزات متاحة'));
                  }
                  return BookingDataTable(bookingEntity: state.bookings);
                } else {
                  return Center(child: Text('Unknown state'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
