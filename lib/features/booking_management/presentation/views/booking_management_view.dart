import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/widgets/custom_appbar_header_widget.dart';
import 'package:palace_systeam_managment/core/widgets/custom_button_with_icon.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';

import 'widgets/booking_data_table.dart';
import 'widgets/booking_search_and_filter.dart';
import 'widgets/booking_status.dart';

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
      child: Column(
        children: [
          CustomAppbarHeaderWidget(
            title: 'إدارة الحجوزات',
            subtitle: 'عرض وإدارة جميع حجوزات الفندق',
            actions: CustomButtonWithIcon(
              text: 'اضافة حجز جديد',
              icon: Icons.add,
            ),
          ),
          SizedBox(height: 24.h),
          BookingStatus(),
          SizedBox(height: 24.h),
          BookingFiltersBar(),
          SizedBox(height: 12.h),

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
    );
  }
}
