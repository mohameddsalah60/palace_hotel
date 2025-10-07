import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/customers/presentation/cubits/custmers_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_search_field.dart';
import 'custmer_details_dialog.dart';

class CustomersViewHeader extends StatelessWidget {
  const CustomersViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: AppColors.wheit,
      ),
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Icon(Icons.group_outlined, size: 32.r, color: AppColors.mainBlue),
          SizedBox(width: 8.w),
          Text(
            'إدارة النزلاء',
            style: AppTextStyles.fontWeight700Size20(context),
          ),
          SizedBox(width: 16.w),
          SizedBox(
            width: 600.w,
            child: CustomSearchField(
              onChanged: (value) {
                context.read<CustmersCubit>().serchCustmer(value);
              },
              hintText: 'ابحث برقم الهوية أو الاسم...',
            ),
          ),
          SizedBox(width: 12.w),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const CustmerDetailsDialog(),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.r, horizontal: 24.r),
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.mainBlue.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person_add_alt_1_outlined,
                    color: AppColors.wheit,
                    size: 24.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'إضافة نزيل جديد',
                    style: AppTextStyles.fontWeight600Size16(
                      context,
                    ).copyWith(color: AppColors.wheit),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
