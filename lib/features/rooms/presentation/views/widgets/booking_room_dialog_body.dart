import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../core/widgets/custom_title_and_subtitle_dialog_header.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';
import '../../cubits/rooms_cubit.dart';
import 'booking_room_dialog_body_form.dart';

class BookingRoomDialogBody extends StatelessWidget {
  const BookingRoomDialogBody({super.key, required this.roomEntity});
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
      child: AlertDialog(
        titlePadding: EdgeInsets.all(0),
        backgroundColor: AppColors.wheit,
        title: CustomTitleAndSubtitleDialogHeader(
          title: 'حجز غرفة جديدة',
          subTitle: 'املأ البيانات التالية لإتمام الحجز',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
        elevation: 10,
        content: BookingRoomDialogBodyForm(roomEntity: roomEntity),
      ),
    );
  }
}
