import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_text_from_field.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';

class PaidField extends StatelessWidget {
  const PaidField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFromField(
            controller: context.read<BookingRoomCubit>().paidAmountController,
            keyboardType: TextInputType.number,
            labelText: 'المبلغ المدفوع',
            icon: Icons.price_check_outlined,
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
                    context.read<BookingRoomCubit>().totalPriceController.text,
                  ) ??
                  0;
              if (paid > total) {
                return 'المبلغ المدفوع لا يمكن ان يكون اكثر من الاجمالي';
              }
              return null;
            },
            onChanged:
                (value) =>
                    context.read<BookingRoomCubit>().updatePaidAmount(value),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomTextFromField(
            controller:
                context.read<BookingRoomCubit>().remainingAmountController,
            keyboardType: TextInputType.number,
            labelText: 'المبلغ المتبقي',
            icon: Icons.price_check_outlined,
            isReadOnly: true,
          ),
        ),
      ],
    );
  }
}
