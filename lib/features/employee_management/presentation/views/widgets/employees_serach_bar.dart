import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/get_user.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button_with_icon.dart';
import '../../../../../core/widgets/custom_search_field.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubit/employee_cubit.dart';
import 'show_add_employee_dialog.dart';

class EmployeesSerachBar extends StatelessWidget {
  const EmployeesSerachBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  context.read<EmployeeCubit>().serchEmployee(value);
                },
                hintText: 'ابحث عن اسم نزيل أو رقم هوية',
              ),
            ),
          ),
        ),

        SizedBox(width: 16.w),

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
                  value: context.watch<EmployeeCubit>().selectedSortType,
                  onChanged: (v) {
                    if (v != null) {
                      context.read<EmployeeCubit>().sortCustmers(v);
                      context.read<EmployeeCubit>().selectedSortType = v;
                    }
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
            title: Text('', style: AppTextStyles.fontWeight400Size14(context)),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 12.r),
              child: CustomButtonWithIcon(
                text: 'اضافة موظف جديد',
                icon: Icons.person_add_alt_1_outlined,
                onPressed: () {
                  if (getUser().permissions.canAddStaff) {
                    showAddEmployeeDialog(context);
                  } else {
                    customSnackBar(
                      context: context,
                      message: 'عفوا لا تمتلك صلاحية',
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
