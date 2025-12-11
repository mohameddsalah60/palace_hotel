import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

class PdfHelper {
  static Future<void> generateAndSaveInvoice(BookingEntity booking) async {
    try {
      final logoBytes = await _loadLogo();
      final pdfBytes = await _generateInvoice(
        booking,
        hotelLogoBytes: logoBytes,
        hotelName: 'Palace Hotel',
      );

      final savePath = await _getSavePath(booking);
      final file = File(savePath);
      await file.create(recursive: true);
      await file.writeAsBytes(pdfBytes);

      debugPrint('تم حفظ الفاتورة في: ${file.path}');

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes,
      );

      await OpenFilex.open(file.path);
    } catch (e) {
      debugPrint('خطأ أثناء إنشاء الفاتورة: $e');
    }
  }

  static Future<Uint8List> _generateInvoice(
    BookingEntity booking, {
    Uint8List? hotelLogoBytes,
    String hotelName = 'Hotel',
  }) async {
    final pdf = pw.Document();

    final fontRegular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Cairo-Regular.ttf'),
    );
    final fontBold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Cairo-Bold.ttf'),
    );

    final now = DateTime.now();
    final formattedDate =
        '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} ${_twoDigits(now.hour)}:${_twoDigits(now.minute)}';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return [
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // رأس الفاتورة مع شعار وخلفية
                  pw.Container(
                    padding: const pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blue900,
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        if (hotelLogoBytes != null)
                          pw.Image(
                            pw.MemoryImage(hotelLogoBytes),
                            width: 80,
                            height: 80,
                          ),
                        pw.Text(
                          hotelName,
                          style: pw.TextStyle(
                            fontSize: 26,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                            font: fontBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  // عنوان الفاتورة
                  pw.Center(
                    child: pw.Text(
                      'فاتورة حجز',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        font: fontBold,
                        color: PdfColors.blue800,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Center(
                    child: pw.Text(
                      'تاريخ الإصدار: $formattedDate',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.grey600,
                        font: fontRegular,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  // بيانات الحجز مع أيقونات وصناديق ملونة
                  _infoBox(
                    'رقم الغرفة',
                    booking.roomID.toString(),
                    PdfColors.blue50,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'اسم النزيل',
                    booking.guestName ?? '',
                    PdfColors.grey200,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'تاريخ الوصول',
                    booking.checkInDate.toString().split(' ').first,
                    PdfColors.blue50,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'تاريخ المغادرة',
                    booking.checkOutDate.toString().split(' ').first,
                    PdfColors.grey200,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'عدد الليالي',
                    booking.nightsCount.toString(),
                    PdfColors.blue50,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'الإجمالي',
                    booking.totalPrice.toStringAsFixed(2),
                    PdfColors.grey200,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'المدفوع',
                    booking.paidAmount.toString(),
                    PdfColors.blue50,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'الحالة',
                    booking.stutasBooking ?? '',
                    PdfColors.grey200,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'طريقة الدفع',
                    booking.paidType,
                    PdfColors.blue50,
                    fontRegular,
                    fontBold,
                  ),
                  _infoBox(
                    'اسم الموظف',
                    booking.employeeName,
                    PdfColors.grey200,
                    fontRegular,
                    fontBold,
                  ),

                  pw.SizedBox(height: 30),

                  // الشروط والأحكام بشكل منظم
                  pw.Text(
                    'الشروط والأحكام:',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      font: fontBold,
                      color: PdfColors.blue900,
                    ),
                  ),
                  pw.Bullet(
                    text:
                        'تسجيل الوصول يبدأ من الساعة 2 ظهرًا وتسجيل المغادرة حتى الساعة 12 ظهرًا.',
                    style: pw.TextStyle(font: fontRegular, fontSize: 12),
                  ),
                  pw.Bullet(
                    text: 'يجب دفع كامل قيمة الحجز قبل الوصول.',
                    style: pw.TextStyle(font: fontRegular, fontSize: 12),
                  ),
                  pw.Bullet(
                    text:
                        'يُرجى الالتزام بالهدوء داخل الفندق وعدم الإضرار بالممتلكات.',
                    style: pw.TextStyle(font: fontRegular, fontSize: 12),
                  ),
                  pw.Bullet(
                    text: 'أي خدمات إضافية قد يتم دفعها عند الاستهلاك.',
                    style: pw.TextStyle(font: fontRegular, fontSize: 12),
                  ),
                  pw.SizedBox(height: 30),

                  // توقيع النزيل
                  pw.Text(
                    'توقيع النزيل:',
                    style: pw.TextStyle(fontSize: 16, font: fontBold),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Container(height: 1, color: PdfColors.grey),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    '(....................................)',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey,
                      font: fontRegular,
                    ),
                  ),
                  pw.SizedBox(height: 30),

                  // شكر
                  pw.Center(
                    child: pw.Text(
                      'شكراً لاختياركم فندقنا',
                      style: pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.grey600,
                        font: fontRegular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  // صناديق البيانات الملونة لكل معلومة
  static pw.Widget _infoBox(
    String title,
    String value,
    PdfColor bgColor,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(vertical: 4),
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: bgColor,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              font: fontBold,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              font: fontRegular,
              fontSize: 13,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  static Future<Uint8List?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/palace_logo_trans.png');
      return data.buffer.asUint8List();
    } catch (e) {
      debugPrint('لم يتم العثور على اللوجو: $e');
      return null;
    }
  }

  static Future<String> _getSavePath(BookingEntity booking) async {
    final now = DateTime.now();
    final formatted =
        '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';

    final fileName = 'فاتورة_${booking.guestName}$formatted.pdf';

    if (Platform.isWindows || Platform.isMacOS) {
      final exeDir = Directory.current.path;
      final invoicesDir = Directory('$exeDir/Invoices');
      if (!await invoicesDir.exists()) {
        await invoicesDir.create(recursive: true);
      }
      return '${invoicesDir.path}/$fileName';
    }

    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      final invoicesDir = Directory(p.join(dir.path, "Invoices"));
      if (!await invoicesDir.exists()) {
        await invoicesDir.create(recursive: true);
      }
      return p.join(invoicesDir.path, fileName);
    }

    throw Exception("Unsupported platform");
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
