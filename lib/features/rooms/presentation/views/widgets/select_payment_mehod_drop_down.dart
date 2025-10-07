import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/booking_room_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';

class SelectPaymentMehodDropDown extends StatelessWidget {
  const SelectPaymentMehodDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء اختيار طريقة الدفع';
              }
              return null;
            },
            value: context.read<BookingRoomCubit>().paymentMethod,
            items:
                context
                    .read<BookingRoomCubit>()
                    .paymentMethods
                    .map(
                      (method) =>
                          DropdownMenuItem(value: method, child: Text(method)),
                    )
                    .toList(),
            onChanged: (value) {
              if (value != null) {
                context.read<BookingRoomCubit>().updatePaymentMethod(value);
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
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomTextFromField(
            controller: context.read<BookingRoomCubit>().totalPriceController,
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
    );
  }
}
