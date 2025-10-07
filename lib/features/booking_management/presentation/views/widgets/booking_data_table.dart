import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

import '../../../../../core/utils/app_colors.dart';

class BookingDataTable extends StatelessWidget {
  const BookingDataTable({super.key, required this.bookingEntity});
  final List<BookingEntity> bookingEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: AppColors.wheit,
      ),
      padding: EdgeInsets.all(16.r),
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
            label: Text(
              'رقم الغرفة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'اسم النزيل',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'تاريخ الوصول',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'تاريخ المغادرة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'عدد الليالي',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'الإجمالي',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'المدفوع',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'الحالة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'طريقة الدفع',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'اسم الموظف',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: List<DataRow>.generate(bookingEntity.length, (index) {
          return DataRow(
            cells: [
              DataCell(Text(bookingEntity[index].roomID.toString())),
              DataCell(Text(bookingEntity[index].guestName!)),
              DataCell(
                Text(
                  bookingEntity[index].checkInDate.toString().split(' ').first,
                ),
              ),
              DataCell(
                Text(
                  bookingEntity[index].checkOutDate.toString().split(' ').first,
                ),
              ),
              DataCell(Text(bookingEntity[index].nightsCount.toString())),
              DataCell(
                Text(bookingEntity[index].totalPrice.toStringAsFixed(2)),
              ),
              DataCell(Text(bookingEntity[index].paidAmount.toString())),
              DataCell(
                Text(
                  'نشط',
                  style: TextStyle(
                    color: bookingEntity[index].getStatusColor('نشط'),
                  ),
                ),
              ), // Placeholder for status
              DataCell(Text(bookingEntity[index].paidType)),
              DataCell(Text(bookingEntity[index].employeeName)),
            ],
          );
        }),
      ),
    );
  }
}
