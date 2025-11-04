import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../booking_management/presentation/cubits/booking_room_cubit.dart';
import 'booking_room_dialog_body_form.dart';

class BookingRoomDialogBody extends StatelessWidget {
  const BookingRoomDialogBody({super.key, required this.roomEntity});
  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingRoomCubit, BookingRoomState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: AppColors.wheit,
          title: Text(
            'حجز غرفة : ${roomEntity.roomId} (${roomEntity.typeRoom})',
            style: AppTextStyles.fontWeight700Size16(
              context,
            ).copyWith(color: AppColors.blackLight, fontSize: 20.sp),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          elevation: 10,
          content: BookingRoomDialogBodyForm(roomEntity: roomEntity),
        );
      },
    );
  }
}
