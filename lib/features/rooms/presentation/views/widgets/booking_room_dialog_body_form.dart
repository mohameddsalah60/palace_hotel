import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/features/customers/presentation/cubits/custmers_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';
import 'booking_button.dart';
import 'guset_name_field.dart';
import 'paid_field.dart';
import 'price_per_night_field.dart';
import 'select_payment_mehod_drop_down.dart';
import 'start_and_end_booking_field.dart';

class BookingRoomDialogBodyForm extends StatelessWidget {
  const BookingRoomDialogBodyForm({super.key, required this.roomEntity});

  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
        child: Form(
          key: context.read<BookingRoomCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              BlocProvider.value(
                value: getIt<CustmersCubit>(),
                child: GusetNameField(roomEntity: roomEntity),
              ),

              SizedBox(height: 16.h),
              StartAndEndBookingField(),
              SizedBox(height: 16.h),
              PricePerNightField(),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        return null;
                      },

                      value:
                          context
                                  .read<BookingRoomCubit>()
                                  .discountController
                                  .text
                                  .isEmpty
                              ? null
                              : context
                                  .read<BookingRoomCubit>()
                                  .discountController
                                  .text,

                      items: List.generate(
                        101,
                        (i) => DropdownMenuItem(
                          value: i.toString(),
                          child: Text('$i%'),
                        ),
                      ),

                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<BookingRoomCubit>()
                              .discountController
                              .text = value;
                          context.read<BookingRoomCubit>().updateDiscount(
                            value,
                          );
                        }
                      },

                      decoration: InputDecoration(
                        labelText: 'نسبة الخصم',
                        prefixIcon: const Icon(
                          Icons.percent,
                          color: AppColors.greyDark,
                        ),
                        filled: true,
                        fillColor: AppColors.wheitDark,
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
                      controller:
                          context.read<BookingRoomCubit>().totalPriceController,
                      keyboardType: TextInputType.number,
                      labelText: 'الإجمالي',
                      icon: Icons.price_change_outlined,
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
              PaidField(),
              SizedBox(height: 16.h),
              SelectPaymentMehodDropDown(),
              SizedBox(height: 16.h),
              CustomTextFromField(
                validator: (p0) {
                  return null;
                },
                controller: context.read<BookingRoomCubit>().notesController,
                keyboardType: TextInputType.text,
                labelText: 'ملاحظات',
                icon: Icons.note_alt_outlined,
                maxLines: 3,
              ),
              SizedBox(height: 16.h),
              BookingButton(roomEntity: roomEntity),
            ],
          ),
        ),
      ),
    );
  }
}
