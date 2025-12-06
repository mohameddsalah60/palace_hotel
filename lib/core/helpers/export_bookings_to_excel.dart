import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../entites/booking_entity.dart';

Future<void> exportBookingsToExcel({
  required List<BookingEntity> bookings,
  required DateTime from,
  required DateTime to,
}) async {
  final filtered =
      bookings.where((b) {
        return b.checkInDate.isAfter(from.subtract(Duration(days: 1))) &&
            b.checkOutDate.isBefore(to.add(Duration(days: 1)));
      }).toList();

  if (filtered.isEmpty) {
    return;
  }

  final excel = Excel.createExcel();
  final sheet = excel['الحجوزات'];

  // Header style
  CellStyle headerStyle = CellStyle(
    bold: true,
    fontColorHex: ExcelColor.fromHexString("#FFFFFF"),
    backgroundColorHex: ExcelColor.fromHexString("#1E88E5"),
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
  );

  List<String> header = [
    'رقم الحجز',
    'رقم الغرفة',
    'اسم النزيل',
    'تاريخ الوصول',
    'تاريخ المغادرة',
    'عدد الليالي',
    'الإجمالي',
    'المدفوع',
    'الحالة',
    'طريقة الدفع',
    'اسم الموظف',
  ];

  for (int i = 0; i < header.length; i++) {
    final cell = sheet.cell(
      CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
    );
    cell.value = TextCellValue(header[i]); // لازم TextCellValue
    cell.cellStyle = headerStyle;
  }
  CellStyle dataStyle = CellStyle(
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
  );

  // إضافة الصفوف
  for (int row = 0; row < filtered.length; row++) {
    final b = filtered[row];
    List<dynamic> values = [
      b.bookingID ?? '-',
      b.roomID.toString(),
      b.guestName ?? b.guestName2 ?? '-',
      b.checkInDate.toString().split(' ')[0],
      b.checkOutDate.toString().split(' ')[0],
      b.nightsCount.toString(),
      b.totalPrice.toStringAsFixed(2),
      b.paidAmount.toStringAsFixed(2),
      b.stutasBooking ?? '-',
      b.paidType,
      b.employeeName,
    ];

    for (int col = 0; col < values.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1),
      );
      cell.value = TextCellValue(
        values[col].toString(),
      ); // تحويل كل حاجة لـ TextCellValue
      cell.cellStyle = dataStyle;
    }
  }

  // فولدر داخل البرنامج
  final appDir = await getApplicationDocumentsDirectory();
  final bookingFolder = Directory("${appDir.path}/الحجوزات");
  if (!bookingFolder.existsSync()) bookingFolder.createSync(recursive: true);

  final filePath =
      "${bookingFolder.path}/booking-${from.year}/${from.month}/${from.day}-${to.year}/${to.month}/${to.day}.xlsx";

  final fileBytes = excel.encode();
  if (fileBytes != null) {
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
  }

  log("✔ تم حفظ التقرير هنا: $filePath");

  await OpenFilex.open(filePath);
}
