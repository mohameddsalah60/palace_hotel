import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../domin/entites/room_entity.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({super.key, required this.roomEntity});

  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingRoomCubit, BookingRoomState>(
      listener: (context, state) {
        if (state is BookingRoomSuccess) {
          customSnackBar(
            context: context,
            message: 'تم الحجز بنجاح',
            color: Colors.green,
          );
          context.read<RoomsCubit>().fetchRooms();

          context.read<BookingRoomCubit>()
            ..getBookings()
            ..clearControls();
          Navigator.pop(context);
        } else if (state is BookingRoomError) {
          context.read<BookingRoomCubit>().clearControls();
          customSnackBar(
            context: context,
            message: 'فشل في الحجز: ${state.message}',
            color: Colors.red,
          );
        }
      },
      child: CustomButton(
        text: 'تأكيد الحجز',
        onPressed: () {
          if (context
              .read<BookingRoomCubit>()
              .formKey
              .currentState!
              .validate()) {
            context.read<BookingRoomCubit>().bookingRoom(room: roomEntity);
          }
        },
      ),
    );
  }
}
