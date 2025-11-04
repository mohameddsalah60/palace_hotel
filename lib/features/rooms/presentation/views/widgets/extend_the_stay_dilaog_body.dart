import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../domin/entites/room_entity.dart';
import 'extend_the_stay_dilaog_body_form.dart';

class ExtendTheStayDilaogBody extends StatelessWidget {
  const ExtendTheStayDilaogBody({super.key, required this.roomEntity});

  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.wheit,
      title: Text(
        'تمديد الاقامة - غرفة رقم : ${roomEntity.roomId} (${roomEntity.typeRoom})',
        style: AppTextStyles.fontWeight700Size16(
          context,
        ).copyWith(color: AppColors.blackLight, fontSize: 20.sp),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      elevation: 10,
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.r),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.26,
          child: ExtendTheStayDilaogBodyForm(roomEntity: roomEntity),
        ),
      ),
    );
  }
}
