import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/permission_item.dart';
import '../../cubit/add_new_employee_cubit.dart';

class PermissionSwitcher extends StatelessWidget {
  const PermissionSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AddNewEmployeeCubit>();

    final perms = permissionsList(cubit.permissionsUsers);

    return Column(
      children:
          perms.map((perm) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(perm.title, style: const TextStyle(fontSize: 15)),
                  Switch(
                    value: perm.value,
                    onChanged: (val) {
                      perm.value = val;
                      cubit.updatePermissionByField(perm.fieldName, val);
                    },
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
