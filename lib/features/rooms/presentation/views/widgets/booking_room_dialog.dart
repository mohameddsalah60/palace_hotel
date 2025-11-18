import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/booking_room_dialog_body.dart';

import '../../../../../core/di/getit_service_loacator.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';
import '../../../domin/entites/room_entity.dart';

class BookingRoomDialog extends StatefulWidget {
  const BookingRoomDialog({super.key, required this.roomEntity});
  final RoomEntity roomEntity;

  @override
  State<BookingRoomDialog> createState() => _BookingRoomDialogState();
}

class _BookingRoomDialogState extends State<BookingRoomDialog> {
  @override
  void dispose() {
    getIt<BookingRoomCubit>().clearControls();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:
          getIt<BookingRoomCubit>()
            ..updatePricePerNight(widget.roomEntity.pricePerNight.toString()),
      child: BookingRoomDialogBody(roomEntity: widget.roomEntity),
    );
  }
}
