import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/helpers/get_user.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../domin/entites/room_entity.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({super.key, required this.roomEntity});

  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'تأكيد الحجز',
      onPressed: () {
        if (context.read<BookingRoomCubit>().formKey.currentState!.validate()) {
          if (getUser().permissions.canCreateBooking) {
            context.read<BookingRoomCubit>().bookingRoom(room: roomEntity);
          } else {
            Navigator.pop(context);
            customSnackBar(context: context, message: 'عفوأ لا تمتلك الصلاحية');
          }
        }
      },
    );
  }
}
