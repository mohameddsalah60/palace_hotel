import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LastMoneyTransactionsDataTable extends StatelessWidget {
  const LastMoneyTransactionsDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        headingRowHeight: 55.h,
        headingTextStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
        ),
        dataTextStyle: TextStyle(color: Colors.grey[900], fontSize: 14.sp),

        // --------- الأعمدة معكوسة ----------
        columns: const [
          DataColumn(label: Text("رقم المعاملة")),
          DataColumn(label: Text("التاريخ")),
          DataColumn(label: Text("العميل")),
          DataColumn(label: Text("طريقة الدفع")),
          DataColumn(label: Text("المبلغ")),
          DataColumn(label: Text("الحالة")),
        ],

        // --------- الصفوف ----------
        rows: [
          _buildRow(
            status: "مكتملة",
            statusColor: Colors.green,
            amount: "\$850.00",
            paymentMethod: "تحويل بنكي",
            paymentColor: Colors.blue,
            paymentIcon: Icons.account_balance,
            userName: "محمد أحمد",
            date: "2024-01-15 14:30",
            id: "TRX-2024-1547#",
          ),
          _buildRow(
            status: "قيد المعالجة",
            statusColor: Colors.orange,
            amount: "\$1,200.00",
            paymentMethod: "تحويل بنكي",
            paymentColor: Colors.blue,
            paymentIcon: Icons.account_balance,
            userName: "نور حسن",
            date: "2024-01-15 10:20",
            id: "TRX-2024-1544#",
          ),
        ],
      ),
    );
  }

  // ---------------------------------------
  // --------- Row Builder -------------
  // ---------------------------------------
  DataRow _buildRow({
    required String status,
    required Color statusColor,
    required String amount,
    required String paymentMethod,
    required Color paymentColor,
    required IconData paymentIcon,
    required String userName,
    required String date,
    required String id,
  }) {
    return DataRow(
      cells: [
        // رقم المعاملة
        DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.w600))),
        // التاريخ
        DataCell(Text(date)),
        // العميل
        DataCell(Text(userName)),
        // طريقة الدفع
        DataCell(Text(paymentMethod, style: TextStyle(color: paymentColor))),
        // المبلغ
        DataCell(
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        // الحالة
        DataCell(Text(status, style: TextStyle(color: statusColor))),
      ],
    );
  }
}
