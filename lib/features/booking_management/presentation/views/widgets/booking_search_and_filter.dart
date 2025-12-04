import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';
import 'package:palace_systeam_managment/core/widgets/custom_button_with_icon.dart';
import 'package:palace_systeam_managment/core/widgets/custom_date_field.dart';
import 'package:palace_systeam_managment/core/widgets/custom_search_field.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';

import '../../../../../core/utils/app_colors.dart';

class BookingFiltersBar extends StatelessWidget {
  const BookingFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: AppColors.wheit,
      ),
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'البحث',
                style: AppTextStyles.fontWeight400Size14(context),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 12.r),
                child: CustomSearchField(
                  onChanged: (value) {
                    context.read<BookingRoomCubit>().searchQuery = value;
                    context.read<BookingRoomCubit>().applyFilters();
                  },
                  hintText: 'ابحث عن اسم نزيل أو رقم غرفة',
                ),
              ),
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'الحالة',
                style: AppTextStyles.fontWeight400Size14(context),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyBorder),
                    color: AppColors.wheit,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButton<String>(
                    value: context.watch<BookingRoomCubit>().statusFilter,
                    onChanged: (v) {
                      context.read<BookingRoomCubit>().statusFilter = v!;
                      context.read<BookingRoomCubit>().applyFilters();
                    },

                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black45,
                    ),
                    itemHeight: 50.h > 48.0 ? 50.h : 48.0,
                    items:
                        [
                          'الكل',
                          'نشط',
                          'مكتمل',
                          'ملغي',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: AppTextStyles.fontWeight400Size14(
                                context,
                              ).copyWith(
                                color: AppColors.blackLight,
                                fontSize: 18.sp,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 16.h),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'الترتيب',
                style: AppTextStyles.fontWeight400Size14(context),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyBorder),
                    color: AppColors.wheit,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButton<String>(
                    value: context.watch<BookingRoomCubit>().sortFilter,
                    onChanged: (v) {
                      context.read<BookingRoomCubit>().sortFilter = v!;
                      context.read<BookingRoomCubit>().applyFilters();
                    },

                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black45,
                    ),
                    itemHeight: 50.h > 48.0 ? 50.h : 48.0,
                    items:
                        [
                          'الاحدث اولآ',
                          'الاقدم اولآ',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: AppTextStyles.fontWeight400Size14(
                                context,
                              ).copyWith(
                                color: AppColors.blackLight,
                                fontSize: 18.sp,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'الحجوزات من',
                style: AppTextStyles.fontWeight400Size14(context),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 12.r),
                child: CustomDateTimeFormField(
                  suffixIcon: Icons.calendar_today,

                  labelText:
                      '${DateTime.now().year}-${DateTime.now().month}-${1}',
                  firstDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    1,
                  ),
                  lastDate: DateTime(DateTime.now().year + 1),

                  onChanged: (date) {
                    context.read<BookingRoomCubit>().fromDate = date;
                    context.read<BookingRoomCubit>().applyFilters();
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'الحجوزات الى',
                style: AppTextStyles.fontWeight400Size14(context),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 12.r),
                child: CustomDateTimeFormField(
                  suffixIcon: Icons.calendar_today,
                  labelText:
                      '${DateTime.now().year}-${DateTime.now().month}-${DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day}',
                  firstDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    1,
                  ),
                  lastDate: DateTime(DateTime.now().year + 1),
                  onChanged: (date) {
                    context.read<BookingRoomCubit>().toDate = date;
                    context.read<BookingRoomCubit>().applyFilters();
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                '',
                style: AppTextStyles.fontWeight400Size14(context),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 12.r),
                child: CustomButtonWithIcon(
                  text: 'تطبيق البحث',
                  icon: Icons.search,
                  onPressed: () {
                    context.read<BookingRoomCubit>().applyFilters();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
