import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';
import 'package:palace_systeam_managment/features/customers/presentation/cubits/custmers_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

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
              SelectPaymentMehodDropDown(),
              SizedBox(height: 16.h),
              PaidField(),
              SizedBox(height: 16.h),
              CustomTextFromField(
                controller:
                    context.read<BookingRoomCubit>().employeeNameController,
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
