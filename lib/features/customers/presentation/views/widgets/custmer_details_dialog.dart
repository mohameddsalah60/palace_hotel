import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/widgets/custom_text_from_field.dart';
import 'package:palace_systeam_managment/features/customers/presentation/cubits/custmers_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/custom_drop_down_button_field.dart';

import '../../../../../core/di/getit_service_loacator.dart';
import '../../../../../core/utils/app_colors.dart';

class CustmerDetailsDialog extends StatelessWidget {
  const CustmerDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CustmersCubit>(),
      child: CustmerDetailsDialogBody(),
    );
  }
}

class CustmerDetailsDialogBody extends StatelessWidget {
  const CustmerDetailsDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('إضافة/تعديل عميل جديد'),
      backgroundColor: AppColors.wheit,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      elevation: 10,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: SingleChildScrollView(
          child: Form(
            key: context.read<CustmersCubit>().formKey,
            child: Column(
              children: [
                CustomTextFromField(
                  controller:
                      context.read<CustmersCubit>().nameCustmerController,
                  labelText: 'اسم الضيف',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  controller: context.read<CustmersCubit>().custmerIdController,
                  keyboardType: TextInputType.number,
                  labelText: 'الرقم القومى / جواز',
                  icon: Icons.credit_card,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    } else if (value.length < 14) {
                      return 'الرقم القومى يجب ان يكون 14 رقم';
                    } else if (value.length > 14) {
                      return 'الرقم القومى يجب ان يكون 14 رقم';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'الرقم القومى يجب أن يحتوي على أرقام فقط';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  controller:
                      context.read<CustmersCubit>().phoneCustmerController,
                  keyboardType: TextInputType.phone,

                  labelText: 'رقم الهاتف',
                  icon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    } else if (value.length < 11) {
                      return 'رقم الهاتف يجب ان يكون 11 رقم';
                    } else if (value.length > 11) {
                      return 'رقم الهاتف يجب ان يكون 11 رقم';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'الرقم الهاتف يجب أن يحتوي على أرقام فقط';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  controller:
                      context.read<CustmersCubit>().addressCustmerController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }

                    return null;
                  },
                  labelText: 'العنوان',
                  icon: Icons.location_on,
                ),
                SizedBox(height: 16.h),

                CustomTextFromField(
                  controller:
                      context.read<CustmersCubit>().jobCustmerController,
                  labelText: 'الوظيفة',
                  icon: Icons.work,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Customdropdownbuttonfield(
                  value: context.read<CustmersCubit>().selectedRelationship,
                  labelText: 'الحالة الاجتماعية',
                  icon: Icons.family_restroom,
                  items:
                      context
                          .read<CustmersCubit>()
                          .realtionshipOptions
                          .map(
                            (option) => DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            ),
                          )
                          .toList(),
                  onChanged: (p0) {
                    context.read<CustmersCubit>().selectedRelationship = p0!;
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'إلغاء',
                        style: TextStyle(color: AppColors.greyDark),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CustmersCubit>().insertCustomer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'حفظ',
                        style: TextStyle(color: AppColors.wheit),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
