import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';

import '../../../../../core/entites/booking_entity.dart';
import '../../../../../core/widgets/custom_alert_dialog.dart';
import 'print_fatora_button.dart';

class BookingConfirmationAction extends StatelessWidget {
  const BookingConfirmationAction({super.key, required this.booking});

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PrintFatoraButton(bookingEntity: booking),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed:
                () => customAlertDialog(
                  context,
                  'هل أنت متأكد من إكمال الحجز؟',
                  'تأكيد التغيير',
                  Colors.green,
                  () {
                    context.read<BookingRoomCubit>().updateBookingState(
                      booking: booking,
                      status: 'مكتمل',
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            label: const Text(
              'إكمال الحجز',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed:
                () => customAlertDialog(
                  context,
                  'هل انت متاكد من آلغاء الحجز ؟',
                  'تأكيد التغيير',
                  Colors.red,
                  () {
                    context.read<BookingRoomCubit>().updateBookingState(
                      booking: booking,
                      status: 'ملغي',
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
            icon: const Icon(Icons.cancel_outlined, color: Colors.white),
            label: const Text(
              'إلغاء الحجز',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
