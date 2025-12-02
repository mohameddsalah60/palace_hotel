import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/widgets/custom_appbar_header_widget.dart';
import 'package:palace_systeam_managment/core/widgets/stat_overview_card.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/search_and_filter_type_bar.dart';

import '../../cubits/rooms_cubit.dart';
import 'add_room_button.dart';
import 'floor_section.dart';
import 'rooms_gried_view.dart';

class RoomsViewBody extends StatelessWidget {
  const RoomsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              CustomAppbarHeaderWidget(
                title: 'ادارة الغرف',
                subtitle: 'إدارة جميع غرف الفندق وحالاتها',
                actions: AddRoomButton(),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 16.w),
                  Expanded(
                    child: StatOverviewCard(
                      icon: Icons.bed,
                      title: 'جميع الغرف',
                      value:
                          context.read<RoomsCubit>().allRooms.length.toString(),
                      subtitle: 'غرفة',
                      colorCard: AppColors.mainBlue,
                    ),
                  ),
                  SizedBox(width: 16.w),

                  Expanded(
                    child: StatOverviewCard(
                      icon: Icons.beenhere_rounded,
                      title: 'الغرف المتاحة',
                      value:
                          context
                              .watch<RoomsCubit>()
                              .countRoomsByStatus('متاح')
                              .toString(),
                      subtitle: 'غرفة',
                      colorCard: AppColors.green,
                    ),
                  ),
                  SizedBox(width: 16.w),

                  Expanded(
                    child: StatOverviewCard(
                      icon: Icons.door_front_door,
                      title: 'الغرف المشغولة',
                      value:
                          context
                              .watch<RoomsCubit>()
                              .countRoomsByStatus('محجوز')
                              .toString(),
                      subtitle: 'غرفة',
                      colorCard: AppColors.warning,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: StatOverviewCard(
                      icon: Icons.handyman,
                      title: 'قيد الصيانة',
                      value:
                          context
                              .watch<RoomsCubit>()
                              .countRoomsByStatus('تحت الصيانة')
                              .toString(),
                      subtitle: 'تحتاج إصلاح',
                      colorCard: AppColors.red,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: StatOverviewCard(
                      icon: Icons.cleaning_services,
                      title: 'قيد التنظيف',
                      value:
                          context
                              .watch<RoomsCubit>()
                              .countRoomsByStatus('هاوس')
                              .toString(),
                      subtitle: 'جاري التنظيف',
                      colorCard: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
              SizedBox(height: 24.h),
              SearchAndFilterTypeBar(
                onChanged: (value) {
                  context.read<RoomsCubit>().search(value);
                },
              ),
              SizedBox(height: 24.h),
              FloorSection(),
              SizedBox(height: 16.h),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          sliver: GridViewListBuilder(),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
      ],
    );
  }
}
