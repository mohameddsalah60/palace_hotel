import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/booking_room_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_search_field.dart';
import '../../../domin/entites/booking_status_entity.dart';
import 'booking_status_card.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: AppColors.wheit,
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),

          // جزء العنوان الرئيسي
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 32.r,
                color: AppColors.mainBlue,
              ),
              SizedBox(width: 8.w),

              Text(
                'إدارة الحجوزات',
                style: AppTextStyles.fontWeight700Size20(
                  context,
                ).copyWith(color: AppColors.mainBlue),
              ),
              SizedBox(width: 16.w),
              SizedBox(
                width: 700.w,
                child: CustomSearchField(
                  onChanged: (value) {
                    context.read<BookingRoomCubit>().search(value);
                  },
                  hintText: 'ابحث عن غرفه او اسم نزيل...',
                ),
              ),
              SizedBox(width: 8.w),
            ],
          ),

          SizedBox(height: 50.h),

          BlocBuilder<BookingRoomCubit, BookingRoomState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: BookingStatusCard(
                      status: BookingStatusEntity(
                        title: 'إجمالي الحجوزات',
                        count:
                            context.read<BookingRoomCubit>().allBookings.length,
                        icon: Icons.receipt_long_rounded,
                        color: AppColors.mainBlue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BookingStatusCard(
                      status: BookingStatusEntity(
                        title: 'مكتملة',
                        count: 0,
                        icon: Icons.check_circle_rounded,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BookingStatusCard(
                      status: BookingStatusEntity(
                        title: 'قيد الانتظار',
                        count: 6,
                        icon: Icons.watch_later_rounded,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BookingStatusCard(
                      status: BookingStatusEntity(
                        title: 'ملغية',
                        count: 0,
                        icon: Icons.cancel_rounded,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // عرض البطاقات باستخدام Wrap لتنسيق تلقائي
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
