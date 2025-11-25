import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button_icon.dart';
import '../../../../../core/entites/user_entity.dart';
import 'permission_dialog.dart';

class EmployeesDataTable extends StatelessWidget {
  const EmployeesDataTable({super.key, required this.employees});
  final List<UserEntity> employees;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: AppColors.wheit,
      ),
      padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 16.r),
      child: DataTable(
        dataRowMaxHeight: 75.h,
        columnSpacing: 24.w,
        headingRowColor: WidgetStateColor.resolveWith(
          (states) => AppColors.wheitDark.withValues(alpha: 0.1),
        ),
        border: TableBorder.all(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.r),
        ),
        columns: const [
          DataColumn(
            label: Text('#', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('الاسم', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text(
              'البريد الالكترونى',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'رقم الهاتف',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'المسمى الوظيفى',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'الرقم القومى',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          DataColumn(
            label: Text(
              'الإجراءات',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: List<DataRow>.generate(employees.length, (index) {
          return DataRow(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(employees[index].name)),
              DataCell(Text(employees[index].email)),
              DataCell(Text(employees[index].phone)),
              DataCell(Text(employees[index].jopTitle, maxLines: 1)),
              DataCell(Text(employees[index].nid, maxLines: 1)),

              DataCell(
                Row(
                  children: [
                    CustomButtonIcon(
                      backgroundColor: AppColors.success,
                      iconColor: AppColors.wheit,
                      tooltip: 'تعديل الصلاحيات',
                      icon: Icons.edit_outlined,
                      onPressed: () {
                        showPermissionsDialog(context, employees[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
