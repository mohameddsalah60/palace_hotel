import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';
import '../../../../../core/services/pdf_helper.dart';
import '../../../../../core/utils/app_colors.dart';

class PrintFatoraButton extends StatelessWidget {
  const PrintFatoraButton({super.key, required this.bookingEntity});
  final BookingEntity bookingEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () async {
          await PdfHelper.generateAndSaveInvoice(bookingEntity);
        },
        icon: const Icon(Icons.print_outlined, color: Colors.white),
        label: const Text(
          'طباعة الفاتورة',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainBlue,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
