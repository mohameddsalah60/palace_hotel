import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/widgets/custom_text_from_field.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';

class PricePerNightField extends StatelessWidget {
  const PricePerNightField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFromField(
            controller:
                context.read<BookingRoomCubit>().pricePerNightController,
            keyboardType: TextInputType.number,
            labelText: 'سعر الليلة',
            icon: Icons.price_check_outlined,
            isReadOnly: true,
            onChanged:
                (value) =>
                    context.read<BookingRoomCubit>().updatePricePerNight(value),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomTextFromField(
            controller: context.read<BookingRoomCubit>().nightsCountController,
            keyboardType: TextInputType.number,
            labelText: 'عدد الليالي',
            icon: Icons.nights_stay_outlined,
            isReadOnly: true,
          ),
        ),
      ],
    );
  }
}
