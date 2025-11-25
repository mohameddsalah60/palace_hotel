import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/widgets/custom_button.dart';

import '../../cubit/add_new_employee_cubit.dart';

class AddNewEmployeeAction extends StatelessWidget {
  const AddNewEmployeeAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: CustomButton(
            backgroundColor: Colors.grey,
            text: "خروج",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: "إضافة موظف",
            onPressed: () {
              context.read<AddNewEmployeeCubit>().addNewEmployee();
            },
          ),
        ),
      ],
    );
  }
}
