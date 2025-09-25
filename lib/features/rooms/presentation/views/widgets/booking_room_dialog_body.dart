import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_date_field.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';
import '../../cubits/booking_room_cubit.dart';

class BookingRoomDialogBody extends StatelessWidget {
  const BookingRoomDialogBody({super.key, required this.roomEntity});
  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingRoomCubit>();

    return BlocBuilder<BookingRoomCubit, BookingRoomState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: AppColors.wheit,
          title: Text(
            'حجز غرفة : ${roomEntity.roomId} (${roomEntity.typeRoom})',
            style: AppTextStyles.fontWeight700Size16(
              context,
            ).copyWith(color: AppColors.blackLight, fontSize: 20.sp),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          elevation: 10,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFromField(
                      controller: cubit.guestNameController,
                      keyboardType: TextInputType.name,
                      labelText: 'اسم الضيف',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال اسم الضيف';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDateTimeFormField(
                            labelText: 'تاريخ الدخول',
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 30),
                            ),
                            initialDate:
                                cubit.selectedCheckInDate ?? DateTime.now(),
                            suffixIcon: Icons.calendar_today,
                            onChanged: (date) {
                              cubit.updateCheckInDate(date!);
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomDateTimeFormField(
                            labelText: 'تاريخ الخروج',
                            firstDate:
                                cubit.selectedCheckInDate ?? DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 30),
                            ),
                            initialDate:
                                cubit.selectedCheckOutDate ??
                                cubit.selectedCheckInDate?.add(
                                  const Duration(days: 1),
                                ) ??
                                DateTime.now().add(const Duration(days: 1)),
                            suffixIcon: Icons.calendar_today,
                            onChanged: (date) {
                              cubit.updateCheckOutDate(date!);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFromField(
                            controller: cubit.pricePerNightController,
                            keyboardType: TextInputType.number,
                            labelText: 'سعر الليلة',
                            icon: Icons.price_check_outlined,
                            isReadOnly: true,
                            onChanged:
                                (value) => cubit.updatePricePerNight(value),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextFromField(
                            controller: cubit.nightsCountController,
                            keyboardType: TextInputType.number,
                            labelText: 'عدد الليالي',
                            icon: Icons.nights_stay_outlined,
                            isReadOnly: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء اختيار طريقة الدفع';
                              }
                              return null;
                            },
                            value: cubit.paymentMethod,
                            items:
                                cubit.paymentMethods
                                    .map(
                                      (method) => DropdownMenuItem(
                                        value: method,
                                        child: Text(method),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                cubit.updatePaymentMethod(value);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'طريقة الدفع',
                              prefixIcon: const Icon(
                                Icons.payment_outlined,
                                color: AppColors.greyDark,
                              ),

                              filled: true,
                              fillColor: AppColors.greyBorder,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextFromField(
                            controller: cubit.totalPriceController,
                            keyboardType: TextInputType.number,
                            labelText: 'الاجمالي',
                            icon: Icons.price_check_outlined,
                            isReadOnly: true,
                            validator: (value) {
                              if (int.tryParse(value ?? '0') == 0) {
                                return 'الرجاء ادخال سعر صحيح';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFromField(
                            controller: cubit.paidAmountController,
                            keyboardType: TextInputType.number,
                            labelText: 'المبلغ المدفوع',
                            icon: Icons.price_check_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء ادخال المبلغ المدفوع';
                              } else {
                                if (int.tryParse(value) == 0) {
                                  return 'الرجاء ادخال مبلغ صحيح';
                                }
                              }
                              final paid = int.tryParse(value) ?? 0;
                              final total =
                                  int.tryParse(
                                    cubit.totalPriceController.text,
                                  ) ??
                                  0;
                              if (paid > total) {
                                return 'المبلغ المدفوع لا يمكن ان يكون اكثر من الاجمالي';
                              }
                              return null;
                            },
                            onChanged: (value) => cubit.updatePaidAmount(value),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextFromField(
                            controller: cubit.remainingAmountController,
                            keyboardType: TextInputType.number,
                            labelText: 'المبلغ المتبقي',
                            icon: Icons.price_check_outlined,
                            isReadOnly: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFromField(
                      controller: cubit.employeeNameController,
                      keyboardType: TextInputType.text,
                      labelText: 'اسم الموظف',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال اسم الموظف';
                        }
                        return null;
                      },
                      icon: Icons.note_alt_outlined,
                    ),

                    SizedBox(height: 16.h),
                    CustomTextFromField(
                      validator: (p0) {
                        return null;
                      },
                      controller: cubit.notesController,
                      keyboardType: TextInputType.text,
                      labelText: 'ملاحظات',
                      icon: Icons.note_alt_outlined,
                      maxLines: 3,
                    ),

                    SizedBox(height: 16.h),
                    CustomButton(
                      text: 'تأكيد الحجز',
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.bookingRoom(room: roomEntity);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
