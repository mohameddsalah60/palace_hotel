import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_search_field.dart';
import 'show_add_employee_dialog.dart';

class EmployeesViewHeader extends StatelessWidget {
  const EmployeesViewHeader({super.key});

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
            'إدارة الموظفين',
            style: AppTextStyles.fontWeight700Size20(context),
          ),
          SizedBox(width: 16.w),
          SizedBox(
            width: 600.w,
            child: CustomSearchField(
              onChanged: (value) {},
              hintText: 'ابحث برقم الهوية أو الاسم...',
            ),
          ),
          SizedBox(width: 12.w),
          InkWell(
            onTap: () {
              showAddEmployeeDialog(context);
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
                    'إضافة موظف جديد',
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
