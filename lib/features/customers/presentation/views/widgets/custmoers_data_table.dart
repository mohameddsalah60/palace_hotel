import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/helpers/get_user.dart';
import 'package:palace_systeam_managment/core/widgets/custom_alert_dialog.dart';
import 'package:palace_systeam_managment/features/customers/domin/entites/customer_entity.dart';
import 'package:palace_systeam_managment/features/customers/presentation/cubits/custmers_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button_icon.dart';
import '../../../../../core/widgets/custom_snackbar.dart';

class CustmoersDataTable extends StatelessWidget {
  const CustmoersDataTable({super.key, required this.customerEntity});
  final List<CustomerEntity> customerEntity;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
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
              'رقم قومى / جواز',
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
              'الوظيفة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'العنوان',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          DataColumn(
            label: Text(
              'الحالة الاجتماعية',
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
        rows: List<DataRow>.generate(customerEntity.length, (index) {
          return DataRow(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(customerEntity[index].nameCustmer)),
              DataCell(Text(customerEntity[index].nationalId)),
              DataCell(Text(customerEntity[index].phoneCustmer)),
              DataCell(Text(customerEntity[index].jobCustmer, maxLines: 1)),
              DataCell(Text(customerEntity[index].addressCustmer)),
              DataCell(Text(customerEntity[index].relationshipCustmer)),
              DataCell(
                Row(
                  children: [
                    CustomButtonIcon(
                      backgroundColor: AppColors.red,
                      iconColor: AppColors.wheit,
                      tooltip: 'حذف',
                      icon: Icons.delete,
                      onPressed: () {
                        if (getUser().permissions.canDeleteGuest) {
                          customAlertDialog(
                            context,
                            'هل انت متآكد من حذف بيانات العميل؟',
                            'تاكيد التغييرات',
                            AppColors.red,
                            () {
                              context.read<CustmersCubit>().deleteCustmer(
                                customerEntity[index],
                              );
                              Navigator.pop(context);
                            },
                          );
                        } else {
                          customSnackBar(
                            context: context,
                            message: 'عفوا لا تمتلك صلاحية',
                          );
                        }
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
