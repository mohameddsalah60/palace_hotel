import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';

class EmailService {
  final String username = 'mohamedsalahdev2004@gmail.com';
  final String password = 'ukrp tyey paxt lfjd';

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', 'en').format(date);
  }

  Future<void> sendBookingEmail({
    required String guestName,
    required int roomID,
    required double totalPrice,
    required double paidAmount,
    required double remainingAmount,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required String ownerEmail,
    required String empolyee,
  }) async {
    final smtpServer = gmail(username, password);

    final htmlMessage = """
    <div style="font-family: Arial, sans-serif; color: #333; line-height: 1.5;">
      <h2 style="color: #1a73e8;">إشعار حجز جديد 🛎️</h2>
      <p>تم تسجيل حجز جديد في الفندق، الرجاء الاطلاع على التفاصيل أدناه:</p>
      <table style="border-collapse: collapse; width: 100%; max-width: 500px; margin-top: 12px;">
        <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>اسم العميل</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">$guestName</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>رقم الغرفة</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">$roomID</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>المبلغ الكلي</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">$totalPrice جنيه</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>المدفوع</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">$paidAmount جنيه</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>المتبقي</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">$remainingAmount جنيه</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>تاريخ الوصول</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">${formatDate(checkInDate)}</td>
        </tr>
        <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>تاريخ المغادرة</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">${formatDate(checkOutDate)}</td>
        </tr> <tr>
          <td style="padding: 8px; border: 1px solid #ccc;"><strong>اسم الموظف</strong></td>
          <td style="padding: 8px; border: 1px solid #ccc;">$empolyee</td>
        </tr>
      </table>
      <p style="margin-top: 16px; font-weight: bold;">✅ الرجاء التأكد من جاهزية الغرفة للضيف.</p>
      <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;" />
      <p style="font-size: 12px; color: #999;">هذا إشعار تلقائي من نظام إدارة فندق Palace. الرجاء عدم الرد على هذا البريد.</p>
    </div>
    """;

    final message =
        Message()
          ..from = Address(username, 'Palace Hotel')
          ..recipients.add(ownerEmail)
          ..subject = 'حجز جديد - الغرفة $roomID 🛎️'
          ..html = htmlMessage;

    try {
      final sendReport = await send(message, smtpServer);
      log('📧 Email sent: $sendReport');
    } catch (e) {
      log('❌ Email failed: $e');
    }
  }
}
