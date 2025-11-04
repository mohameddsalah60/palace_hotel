import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/booking_room_dialog.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/extend_the_stay_dilog.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../cubits/rooms_cubit.dart';
import 'new_room_form_dialog.dart';
import 'room_item_info_row.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key, required this.roomEntity});
  final RoomEntity roomEntity;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (roomEntity.statusRoom == 'محجوز') {
          showDialog(
            context: context,
            builder: (context) {
              return ExtendTheStayDialog(roomEntity: roomEntity);
            },
          );
        } else if (roomEntity.statusRoom == 'تحت الصيانة') {
          customSnackBar(
            context: context,
            message: 'لا يمكن حجز الغرفة لانها تحت الصيانة حاليآ',
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return BookingRoomDialog(roomEntity: roomEntity);
            },
          );
        }
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return NewRoomFormDialog(roomEntity: roomEntity);
          },
        ).then((_) {
          if (context.mounted) {
            context.read<RoomsCubit>().formController.clear();
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.wheit,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyCheckBox, width: 0.8.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoomItemInfoRow(
                  title: "الغرفة ${roomEntity.roomId}",
                  icon: Icons.bed_rounded,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),

                  decoration: BoxDecoration(
                    color: roomStatusColor(roomEntity.statusRoom),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    roomEntity.statusRoom,
                    style: AppTextStyles.fontWeight600Size16(
                      context,
                    ).copyWith(color: AppColors.wheit, fontSize: 14.sp),
                  ),
                ),
              ],
            ),

            RoomItemInfoRow(
              title: roomEntity.typeRoom,
              icon: Icons.bookmark_border_outlined,
            ),

            SizedBox(height: 8.h),
            RoomItemInfoRow(
              title: "الدور ${roomEntity.floorRoom}",
              icon: Icons.location_on_outlined,
            ),
            SizedBox(height: 8.h),
            RoomItemInfoRow(
              title: roomEntity.descriptionRoom,
              icon: Icons.view_in_ar,
            ),
            SizedBox(height: 8.h),
            RoomItemInfoRow(
              title: "${roomEntity.pricePerNight} جنية/ليلة",
              icon: Icons.monetization_on_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Color roomStatusColor(String status) {
    switch (status) {
      case 'متاح':
        return AppColors.success;
      case 'محجوز':
        return AppColors.penaltyRedLight;
      default:
        return AppColors.mainBlue;
    }
  }
}
