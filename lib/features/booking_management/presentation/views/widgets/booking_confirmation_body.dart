import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/views/widgets/print_fatora_button.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import '../../../../../core/entites/booking_entity.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_alert_dialog.dart';
import 'booking_confirmation_action.dart';

class BookingConfirmationBody extends StatelessWidget {
  const BookingConfirmationBody({super.key, required this.booking});
  final BookingEntity booking;
  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingRoomCubit, BookingRoomState>(
      listener: (context, state) {
        if (state is UpdateStateBooking) {
          customSnackBar(
            context: context,
            message: 'تم تحديث حالة الحجز بنجاح',
            color: Colors.green,
          );
          context.read<RoomsCubit>().fetchRooms();
        } else if (state is DeleteBooking) {
          customSnackBar(
            context: context,
            message: 'تم حذف الحجز بنجاح',
            color: Colors.green,
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'تفاصيل الحجز لغرفة رقم ${booking.roomID}',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Divider(height: 20.h, color: Colors.grey.shade300),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person_4_outlined, size: 25.sp),
              SizedBox(width: 8.w),
              Text(
                'اسم النزيل :',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(booking.guestName!, style: TextStyle(fontSize: 16.sp)),
              booking.guestName2 != ""
                  ? Text(
                    "  +  ${booking.guestName2!}",
                    style: TextStyle(fontSize: 16.sp),
                  )
                  : SizedBox.shrink(),
            ],
          ),
          buildDetailRow(
            'تاريخ الوصول',
            booking.checkInDate.toString().split(' ').first,
            Icons.date_range_outlined,
          ),
          buildDetailRow(
            'تاريخ المغادرة',
            booking.checkOutDate.toString().split(' ').first,
            Icons.date_range_outlined,
          ),
          buildDetailRow(
            'عدد الليالي',
            booking.nightsCount.toString(),
            Icons.nights_stay_outlined,
          ),
          buildDetailRow(
            'الإجمالي',
            booking.totalPrice.toStringAsFixed(2),
            Icons.monetization_on_outlined,
          ),
          buildDetailRow(
            'المدفوع',
            booking.paidAmount.toString(),
            Icons.monetization_on_outlined,
          ),
          buildDetailRow('طريقة الدفع', booking.paidType, Icons.money),

          buildDetailRow(
            'اسم الموظف',
            booking.employeeName,
            Icons.person_outline_outlined,
          ),
          if (booking.notes != null && booking.notes!.isNotEmpty)
            buildDetailRow('ملاحظات', booking.notes!, Icons.note_sharp)
          else
            SizedBox.shrink(),

          SizedBox(height: 16.h),
          buildStatusRow(
            'الحالة الحالية',
            booking.stutasBooking!,
            color: booking.getStatusColor(booking.stutasBooking!),
          ),
          SizedBox(height: 16.h),
          booking.stutasBooking == 'نشط'
              ? Column(
                children: [
                  buildStatusRow(
                    'المبلغ المتبقى',
                    (booking.totalPrice - booking.paidAmount).toString(),
                    color: booking.getStatusColor(booking.stutasBooking!),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'الرجاء العلم اي اجراء فى الحجز يعني تم دفع المبلغ بالكامل *',
                    style: AppTextStyles.fontWeight400Size14(
                      context,
                    ).copyWith(color: AppColors.greyCheckBox),
                  ),
                  SizedBox(height: 24.h),
                  Divider(height: 20.h, color: Colors.grey.shade300),
                  SizedBox(height: 16.h),

                  BookingConfirmationAction(booking: booking),
                ],
              )
              : Column(
                children: [
                  Divider(height: 20.h, color: Colors.grey.shade300),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      PrintFatoraButton(bookingEntity: booking),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            customAlertDialog(
                              context,
                              'هل أنت متأكد من حذف الحجز؟',
                              'تأكيد التغييرات',
                              Colors.red,
                              () {
                                context.read<BookingRoomCubit>().deleteBooking(
                                  booking: booking,
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'حذف الحجز',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 25.sp),
          SizedBox(width: 8.w),
          Text(
            '$label:',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text(value, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }

  Widget buildStatusRow(String label, String value, {required Color color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
