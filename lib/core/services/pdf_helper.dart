import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';

class PdfHelper {
  // 🔹 إنشاء الفاتورة
  static Future<void> generateAndSaveInvoice(BookingEntity booking) async {
    try {
      final logoBytes = await _loadLogo();
      final pdfBytes = await _generateInvoice(
        booking,
        hotelLogoBytes: logoBytes,
        hotelName: 'Palace Hotel',
      );

      // 🔹 تحديد مسار الحفظ بناءً على النظام
      final savePath = await _getSavePath(booking);

      // 🔹 حفظ الفايل
      final file = File(savePath);
      await file.create(recursive: true);
      await file.writeAsBytes(pdfBytes);

      // 🔹 فتح الفاتورة مباشرة للطباعة أو المعاينة

      debugPrint('✅ تم حفظ الفاتورة في: ${file.path}');
    } catch (e) {
      debugPrint('❌ خطأ أثناء إنشاء الفاتورة: $e');
    }
  }

  // 🟢 توليد ملف PDF بالفاتورة
  static Future<Uint8List> _generateInvoice(
    BookingEntity booking, {
    Uint8List? hotelLogoBytes,
    String hotelName = 'Hotel',
  }) async {
    final pdf = pw.Document();

    // 🇴 تحميل الخطوط العربية
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
      pw.Page(
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (hotelLogoBytes != null)
                  pw.Center(
                    child: pw.Image(
                      pw.MemoryImage(hotelLogoBytes),
                      width: 100,
                      height: 100,
                    ),
                  ),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    hotelName,
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      font: fontBold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Center(
                  child: pw.Text(
                    'فاتورة الحجز',
                    style: pw.TextStyle(
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                      font: fontBold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
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
                pw.SizedBox(height: 16),
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  children: [
                    _buildRow(
                      'رقم الغرفة',
                      booking.roomID.toString(),
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'اسم النزيل',
                      booking.guestName ?? '',
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'تاريخ الوصول',
                      booking.checkInDate.toString().split(' ').first,
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'تاريخ المغادرة',
                      booking.checkOutDate.toString().split(' ').first,
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'عدد الليالي',
                      booking.nightsCount.toString(),
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'الإجمالي',
                      booking.totalPrice.toStringAsFixed(2),
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'المدفوع',
                      booking.paidAmount.toString(),
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'الحالة',
                      booking.stutasBooking ?? '',
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'طريقة الدفع',
                      booking.paidType,
                      fontRegular,
                      fontBold,
                    ),
                    _buildRow(
                      'اسم الموظف',
                      booking.employeeName,
                      fontRegular,
                      fontBold,
                    ),
                  ],
                ),
                pw.SizedBox(height: 40),
                pw.Text(
                  'توقيع النزيل:',
                  style: pw.TextStyle(fontSize: 16, font: fontBold),
                ),
                pw.SizedBox(height: 30),
                pw.Container(height: 1, color: PdfColors.grey),
                pw.SizedBox(height: 10),
                pw.Text(
                  '(....................................)',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey,
                    font: fontRegular,
                  ),
                ),
                pw.Spacer(),
                pw.Center(
                  child: pw.Text(
                    'Thank you for choosing our hotel',
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: PdfColors.grey600,
                      font: fontRegular,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // 🟣 تحميل اللوجو من الأصول
  static Future<Uint8List?> _loadLogo() async {
    try {
      final data = await rootBundle.load('assets/images/palace_logo_trans.png');
      return data.buffer.asUint8List();
    } catch (e) {
      debugPrint('⚠️ لم يتم العثور على اللوجو: $e');
      return null;
    }
  }

  // 🟡 تحديد مسار الحفظ
  static Future<String> _getSavePath(BookingEntity booking) async {
    final now = DateTime.now();
    final formatted =
        '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';
    final fileName = 'فاتورة_${booking.guestName}_$formatted.pdf';

    Directory appDir;

    if (Platform.isMacOS || Platform.isWindows) {
      appDir = await getApplicationSupportDirectory();
    } else {
      appDir = await getApplicationDocumentsDirectory();
    }

    final invoicesDir = Directory('${appDir.path}/فواتير');
    if (!await invoicesDir.exists()) {
      await invoicesDir.create(recursive: true);
    }

    return '${invoicesDir.path}/$fileName';
  }

  static pw.TableRow _buildRow(
    String title,
    String value,
    pw.Font fontRegular,
    pw.Font fontBold,
  ) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            title,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: fontBold),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(value, style: pw.TextStyle(font: fontRegular)),
        ),
      ],
    );
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
