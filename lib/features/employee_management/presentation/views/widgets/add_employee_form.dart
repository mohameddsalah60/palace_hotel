import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/employee_management/presentation/cubit/add_new_employee_cubit.dart';

import '../../../../../core/widgets/custom_text_from_field.dart';

class AddEmployeeForm extends StatelessWidget {
  const AddEmployeeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AddNewEmployeeCubit>().fromKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFromField(
            labelText: "اسم الموظف",
            icon: Icons.person,
            controller: context.read<AddNewEmployeeCubit>().nameController,
          ),
          SizedBox(height: 12),
          CustomTextFromField(
            labelText: "البريد الإلكتروني",
            icon: Icons.email,
            controller: context.read<AddNewEmployeeCubit>().emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب ادخال بريد الكترونى';
              } else if (!value.contains('@palacesysteam.com')) {
                return 'يجب ادخال بريد الكترونى صحيح';
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          CustomTextFromField(
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
            controller: context.read<AddNewEmployeeCubit>().phoneController,
          ),
          SizedBox(height: 12),
          CustomTextFromField(
            labelText: "الرقم القومي",
            icon: Icons.credit_card,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'هذا الحقل مطلوب';
              } else if (value.length < 14) {
                return 'الرقم القومي يجب ان يكون 14 رقم';
              } else if (value.length > 14) {
                return 'الرقم القومي يجب ان يكون 14 رقم';
              } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'الرقم القومى يجب أن يحتوي على أرقام فقط';
              }
              return null;
            },
            controller: context.read<AddNewEmployeeCubit>().nidController,
          ),
          SizedBox(height: 12),
          CustomTextFromField(
            labelText: "المسمى الوظيفي",
            icon: Icons.work,
            controller: context.read<AddNewEmployeeCubit>().jobTitleController,
          ),
        ],
      ),
    );
  }
}
