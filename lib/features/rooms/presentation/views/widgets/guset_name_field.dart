import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/booking_room_cubit.dart';

import '../../../domin/entites/room_entity.dart';
import 'customer_search_manual.dart';

class GusetNameField extends StatelessWidget {
  const GusetNameField({super.key, required this.roomEntity});

  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomerSearchManual(
          controller_: context.read<BookingRoomCubit>().guestNameController,
          onSelected: (suggestion) {
            context.read<BookingRoomCubit>().setCustmerText(
              context.read<BookingRoomCubit>().guestNameController,
              suggestion.toString(),
            );
          },
        ),
        SizedBox(height: roomEntity.typeRoom == 'دبل' ? 16.h : 0),
        roomEntity.typeRoom == 'دبل'
            ? CustomerSearchManual(
              controller_:
                  context.read<BookingRoomCubit>().guestName2Controller,
              onSelected: (suggestion) {
                context.read<BookingRoomCubit>().setCustmerText(
                  context.read<BookingRoomCubit>().guestName2Controller,
                  suggestion.toString(),
                );
              },
            )
            : SizedBox.shrink(),
      ],
    );
  }
}
