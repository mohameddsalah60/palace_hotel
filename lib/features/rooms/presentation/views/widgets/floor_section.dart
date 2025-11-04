import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

class FloorSection extends StatelessWidget {
  const FloorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(context.read<RoomsCubit>().floors.length, (
          index,
        ) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<RoomsCubit>().formController.currntIndexFloor =
                    index;
                context.read<RoomsCubit>().setSelectedFloor(
                  context.read<RoomsCubit>().floors[index],
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color:
                      index ==
                              context
                                  .watch<RoomsCubit>()
                                  .formController
                                  .currntIndexFloor
                          ? AppColors.mainBlue
                          : AppColors.greyBorder,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.apartment,
                          size: 45.r,
                          color:
                              index ==
                                      context
                                          .watch<RoomsCubit>()
                                          .formController
                                          .currntIndexFloor
                                  ? AppColors.wheit
                                  : AppColors.blackLight.withValues(alpha: .15),
                        ),
                        SizedBox(width: 16.w),

                        Column(
                          children: [
                            Text(
                              context.read<RoomsCubit>().floors[index] == 'الكل'
                                  ? 'الكل'
                                  : 'الدور ${context.read<RoomsCubit>().floors[index]}',
                              style: AppTextStyles.fontWeight600Size16(
                                context,
                              ).copyWith(
                                color:
                                    index ==
                                            context
                                                .watch<RoomsCubit>()
                                                .formController
                                                .currntIndexFloor
                                        ? AppColors.wheit
                                        : AppColors.blackLight,
                              ),
                            ),
                            SizedBox(width: 24.h),

                            Text(
                              'الطابق',
                              style: AppTextStyles.fontWeight400Size14(
                                context,
                              ).copyWith(
                                color:
                                    index ==
                                            context
                                                .watch<RoomsCubit>()
                                                .formController
                                                .currntIndexFloor
                                        ? AppColors.wheit
                                        : AppColors.blackLight.withValues(
                                          alpha: 0.7,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
