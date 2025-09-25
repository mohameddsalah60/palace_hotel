import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/booking_room_dialog_body.dart';

import '../../../../../core/di/getit_service_loacator.dart';
import '../../../domin/entites/room_entity.dart';
import '../../cubits/booking_room_cubit.dart';
import '../../cubits/rooms_cubit.dart';

class BookingRoomDialog extends StatelessWidget {
  const BookingRoomDialog({super.key, required this.roomEntity});
  final RoomEntity roomEntity;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<RoomsCubit>()),
        BlocProvider(
          create:
              (_) =>
                  BookingRoomCubit()
                    ..updatePricePerNight(roomEntity.pricePerNight.toString()),
        ),
      ],

      child: BookingRoomDialogBody(roomEntity: roomEntity),
    );
  }
}
