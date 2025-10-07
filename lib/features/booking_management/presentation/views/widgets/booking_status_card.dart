import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../domin/entites/booking_status_entity.dart';

class BookingStatusCard extends StatefulWidget {
  final BookingStatusEntity status;
  const BookingStatusCard({super.key, required this.status});

  @override
  State<BookingStatusCard> createState() => _BookingStatusCardState();
}

class _BookingStatusCardState extends State<BookingStatusCard> {
  // متغير لتتبع حالة مرور الماوس
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // تحديد قيم الظل بناءً على حالة التمرير، وزيادة قيم الظل
    final double blurRadius =
        _isHovering ? 45 : 8; // زيادة كبيرة للظل عند التمرير
    final Offset shadowOffset =
        _isHovering
            ? const Offset(0, 20) // إزاحة كبيرة عند التمرير
            : const Offset(0, 4); // ظل افتراضي

    return MouseRegion(
      // عند دخول الماوس
      onEnter: (_) => setState(() => _isHovering = true),
      // عند خروج الماوس
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ), // زيادة مدة التحول لتكون الحركة أنعم
        curve: Curves.easeOutCubic, // منحنى حركة أكثر نعومة
        // تغيير الحجم عند التمرير
        width: _isHovering ? 205.w : 200.w,
        height: _isHovering ? 185.h : 180.h,

        margin: EdgeInsets.symmetric(horizontal: 8.r),
        decoration: BoxDecoration(
          color: widget.status.color,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: _isHovering ? 0.5 : 0.12,
              ), // زيادة العتامة
              blurRadius: blurRadius,
              offset: shadowOffset,
            ),
          ],
        ),
        child: Stack(
          children: [
            // الأيقونة الكبيرة في الزاوية اليسرى السفلية بزاوية
            Positioned(
              bottom: -40.h,
              left: -40.w,
              child: Transform.rotate(
                angle: -0.5,
                child: Icon(
                  widget.status.icon,
                  size: 200.r,
                  color: AppColors.wheit.withValues(alpha: 0.2),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // الرقم بشكل كبير (اللون أبيض)
                  Text(
                    widget.status.count.toString(),
                    style: AppTextStyles.fontWeight700Size32(
                      context,
                    ).copyWith(color: AppColors.wheit, fontSize: 50.sp),
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(height: 8.h),

                  // النص (الحالة) باللون الأبيض
                  Text(
                    widget.status.title,
                    style: AppTextStyles.fontWeight600Size16(
                      context,
                    ).copyWith(color: AppColors.wheit),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
