import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';
import 'package:palace_systeam_managment/core/widgets/custom_button.dart';
import 'package:palace_systeam_managment/core/entites/user_entity.dart';
import 'package:palace_systeam_managment/features/employee_management/presentation/cubit/add_new_employee_cubit.dart';
import '../../../../../core/utils/app_colors.dart';

import '../../../domain/entities/permission_item.dart';

class PermissionsDialogBody extends StatelessWidget {
  const PermissionsDialogBody({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "الصلاحيات",
                style: AppTextStyles.fontWeight700Size20(context),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 34.r,
                  color: AppColors.greyCheckBox,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          Column(
            children:
                permissionsList(user.permissions).map((perm) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(perm.title, style: const TextStyle(fontSize: 15)),
                        BlocBuilder<AddNewEmployeeCubit, AddNewEmployeeState>(
                          builder: (context, state) {
                            if (state is UpdateUI) {
                              return Switch(
                                value: perm.value,
                                onChanged: (val) {
                                  perm.value = val;
                                  context
                                      .read<AddNewEmployeeCubit>()
                                      .updatePermissionByField(
                                        perm.fieldName,
                                        val,
                                      );
                                },
                              );
                            } else {
                              return Switch(
                                value: perm.value,
                                onChanged: (val) {
                                  perm.value = val;

                                  context
                                      .read<AddNewEmployeeCubit>()
                                      .updatePermissionByField(
                                        perm.fieldName,
                                        val,
                                      );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: 'حفظ الصلاحيات',
            onPressed: () {
              context.read<AddNewEmployeeCubit>().updateEmployee(user);
            },
          ),
        ],
      ),
    );
  }
}
