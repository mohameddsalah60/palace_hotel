import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/widgets/custom_button.dart';
import 'package:palace_systeam_managment/core/widgets/custom_date_field.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';

import '../../../../../core/entites/booking_entity.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_title_and_subtitle_dialog_header.dart';
import '../../cubits/booking_export_cubit.dart';

void extractBookingDataDialog({
  required BuildContext context,
  required List<BookingEntity> bookings,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (_) => BookingExportCubit(),
        child: AlertDialog(
          titlePadding: EdgeInsets.all(0),
          backgroundColor: AppColors.wheit,
          title: CustomTitleAndSubtitleDialogHeader(
            title: 'تصدير بيانات الحجوزات',
            subTitle: 'تصدير البيانات إلى ملف Excel',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
          elevation: 10,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [DateTimeFields()],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150.w,
                  child: CustomButton(
                    text: 'الغاء',
                    backgroundColor: AppColors.greyCheckBox,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 250.w,
                  child: BlocConsumer<BookingExportCubit, BookingExportState>(
                    listener: (context, state) {
                      if (state is BookingExportSuccess) {
                        customSnackBar(
                          context: context,
                          message: '✔ تم تصدير التقرير بنجاح',
                          color: AppColors.green,
                        );

                        Navigator.pop(context);
                      } else if (state is BookingExportFailure) {
                        customSnackBar(
                          context: context,
                          message: '❌ فشل التصدير: ${state.error}',
                          color: AppColors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text:
                            state is BookingExportLoading
                                ? 'جارٍ التصدير...'
                                : 'تصدير البيانات',
                        onPressed:
                            state is BookingExportLoading
                                ? null
                                : () {
                                  context
                                      .read<BookingExportCubit>()
                                      .exportBookings(bookings: bookings);
                                },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class DateTimeFields extends StatelessWidget {
  const DateTimeFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('من تاريخ'),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CustomDateTimeFormField(
                initialDate: DateTime.now(),
                suffixIcon: Icons.date_range,
                labelText: 'yyyy/mm/dd',
                firstDate: DateTime(2025, 1, 1),
                lastDate: DateTime.now(),
                onChanged: (d) {
                  if (d != null) {
                    context.read<BookingExportCubit>().from = d;
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('الي تاريخ'),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CustomDateTimeFormField(
                initialDate: DateTime.now(),
                suffixIcon: Icons.date_range,
                labelText: 'yyyy/mm/dd',
                firstDate: DateTime(2025, 1, 1),
                lastDate: DateTime.now(),
                onChanged: (d) {
                  if (d != null) {
                    context.read<BookingExportCubit>().to = d;
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
