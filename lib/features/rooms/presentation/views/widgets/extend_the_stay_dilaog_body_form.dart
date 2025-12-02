import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/extend_the_stay_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_date_field.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';
import '../../../domin/entites/room_entity.dart';
import 'booking_room_dialog.dart';

class ExtendTheStayDilaogBodyForm extends StatelessWidget {
  const ExtendTheStayDilaogBodyForm({super.key, required this.roomEntity});

  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.read<BookingRoomCubit>();
    final extendCubit = context.read<ExtendTheStayCubit>();
    final booking = bookingCubit.getBookingByIdRoom(
      idRoom: roomEntity.roomId.toString(),
    );

    // نهيّئ البيانات أول ما الفورم يفتح
    extendCubit.initializeData(room: roomEntity, booking: booking);

    return BlocBuilder<ExtendTheStayCubit, ExtendTheStayState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: extendCubit.formKey,
            child: Column(
              children: [
                // اسم النزيل
                _infoBox(
                  icon: Icons.person,
                  text: 'اسم النزيل : ${booking.guestName}',
                  context: context,
                ),
                SizedBox(height: 16.h),

                // تاريخ الوصول
                _infoBox(
                  icon: Icons.date_range,
                  text:
                      'تاريخ الوصول : ${booking.checkInDate.year}/${booking.checkInDate.month}/${booking.checkInDate.day}',
                  context: context,
                ),
                SizedBox(height: 16.h),

                // تاريخ المغادرة القديم
                _infoBox(
                  icon: Icons.date_range,
                  text:
                      'تاريخ المغادرة : ${booking.checkOutDate.year}/${booking.checkOutDate.month}/${booking.checkOutDate.day}',
                  context: context,
                ),

                SizedBox(height: 8.h),
                Divider(color: AppColors.greyDiveder),
                SizedBox(height: 8.h),

                // تاريخ المغادرة الجديد
                CustomDateTimeFormField(
                  onChanged: (date) {
                    if (date != null) {
                      extendCubit.updateSelectedCheckOutDate(date);
                    }
                  },
                  firstDate: booking.checkOutDate.add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  labelText: 'تاريخ المغادرة الجديد',
                  suffixIcon: Icons.date_range,
                  colorIcon: AppColors.black,
                ),

                SizedBox(height: 16.h),

                // المبلغ المدفوع
                CustomTextFromField(
                  controller: extendCubit.paidAmountController,
                  onChanged: extendCubit.updatePaidAmount,
                  labelText: 'المبلغ المدفوع',
                  icon: Icons.price_check_outlined,
                  iconColor: AppColors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال المبلغ المدفوع';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'الرجاء ادخال مبلغ صحيح';
                    } else {
                      if (int.tryParse(value) == 0) {
                        return 'الرجاء ادخال مبلغ صحيح';
                      }
                    }
                    final paid = int.tryParse(value) ?? 0;
                    final total =
                        int.tryParse(
                          context
                              .read<ExtendTheStayCubit>()
                              .totalExtendPriceController
                              .text,
                        ) ??
                        0;
                    if (paid > total) {
                      return 'المبلغ المدفوع لا يمكن ان يكون اكثر من الاجمالي';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // ملخص التمديد
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.greyBorder,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ملخص التمديد :',
                        style: AppTextStyles.fontWeight700Size16(context),
                      ),
                      SizedBox(height: 10.h),

                      _summaryRow(
                        context: context,
                        title: 'عدد الليالي :',
                        value: extendCubit.getDaysDifferenceText(
                          booking.checkOutDate,
                          extendCubit.selectedCheckOutDate ??
                              booking.checkOutDate,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      _summaryRow(
                        context: context,
                        title: 'سعر الليلة :',
                        value: '${roomEntity.pricePerNight} جنية',
                      ),
                      SizedBox(height: 10.h),

                      _summaryRow(
                        context: context,
                        title: 'إجمالي التمديد :',
                        value:
                            '${extendCubit.totalExtendPriceController.text} جنية',
                        isBlue: true,
                      ),
                      SizedBox(height: 16.h),

                      _summaryRow(
                        context: context,
                        title: 'المبلغ المدفوع :',
                        value: '${extendCubit.paidAmountController.text} جنية',
                      ),
                      SizedBox(height: 16.h),

                      _summaryRow(
                        context: context,
                        title: 'المبلغ المتبقي :',
                        value:
                            '${extendCubit.remainingAmountController.text} جنية',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'اضافة حجز جديد',
                        backgroundColor: AppColors.success,
                        onPressed: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BookingRoomDialog(roomEntity: roomEntity);
                            },
                          );
                        },
                      ),
                    ),

                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomButton(
                        text: 'تأكيد التمديد',
                        backgroundColor: AppColors.mainBlue,
                        onPressed: () {
                          if (context
                              .read<ExtendTheStayCubit>()
                              .formKey
                              .currentState!
                              .validate()) {
                            extendCubit.confirmExtendStay(booking: booking);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoBox({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyBorder,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.fontWeight600Size16(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow({
    required BuildContext context,
    required String title,
    required String value,
    bool isBlue = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.fontWeight600Size16(context)),
        Text(
          value,
          style: AppTextStyles.fontWeight600Size16(
            context,
          ).copyWith(color: isBlue ? AppColors.mainBlue : AppColors.black),
        ),
      ],
    );
  }
}
