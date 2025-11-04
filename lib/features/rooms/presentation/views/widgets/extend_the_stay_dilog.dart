import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/extend_the_stay_cubit.dart';

import '../../../../../core/di/getit_service_loacator.dart';

import '../../../domin/entites/room_entity.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';
import '../../cubits/rooms_cubit.dart';
import 'extend_the_stay_dilaog_body.dart';

class ExtendTheStayDialog extends StatelessWidget {
  const ExtendTheStayDialog({super.key, required this.roomEntity});
  final RoomEntity roomEntity;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<RoomsCubit>()),
        BlocProvider.value(value: getIt<ExtendTheStayCubit>()),
        BlocProvider.value(value: getIt<BookingRoomCubit>()),
      ],
      child: BlocListener<ExtendTheStayCubit, ExtendTheStayState>(
        listener: (context, state) {
          if (state is ExtendTheStaySuccess) {
            customSnackBar(
              context: context,
              message: 'تم تمديد الاقامة بنجاح',
              color: Colors.green,
            );
            context.read<BookingRoomCubit>().getBookings();
            Navigator.of(context).pop();
          } else if (state is ExtendTheStayError) {
            customSnackBar(
              context: context,
              message: 'فشل في تمديد الاقامة: ${state.message}',
              color: Colors.red,
            );
          }
        },
        child: ExtendTheStayDilaogBody(roomEntity: roomEntity),
      ),
    );
  }
}
