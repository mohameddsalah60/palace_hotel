import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_search_field.dart';
import '../../cubits/rooms_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class SearchAndFilterTypeBar extends StatelessWidget {
  const SearchAndFilterTypeBar({super.key, this.onChanged});
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final roomsCubit = context.watch<RoomsCubit>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomSearchField(
              onChanged: onChanged,
              hintText: 'ابحث عن غرفة',
            ),
          ),
          SizedBox(width: 8.w),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyBorder),
                color: AppColors.wheit,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: DropdownButton<String>(
                value: roomsCubit.searchSelectedStatus,
                onChanged: (String? newValue) {
                  roomsCubit.setSelectedSearchStatus(newValue);
                },
                isExpanded: true,
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black45,
                ),
                itemHeight: 50.h > 48.0 ? 50.h : 48.0,
                items:
                    roomsCubit.searchStatuses.map<DropdownMenuItem<String>>((
                      String value,
                    ) {
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
          SizedBox(width: 8.w),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyBorder),
                color: AppColors.wheit,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: DropdownButton<String>(
                value: roomsCubit.searchSelectedType,
                onChanged: (String? newValue) {
                  roomsCubit.setSelectedSearchType(newValue);
                },
                isExpanded: true,
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black45,
                ),
                itemHeight: 50.h > 48.0 ? 50.h : 48.0,
                items:
                    roomsCubit.searchTypes.map<DropdownMenuItem<String>>((
                      String value,
                    ) {
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
        ],
      ),
    );
  }
}
