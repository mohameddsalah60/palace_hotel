import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class RoomEntity {
  final int? roomId;
  final String typeRoom;
  final String floorRoom;
  final String descriptionRoom;
  final int pricePerNight;
  final String statusRoom;

  RoomEntity({
    this.roomId,
    required this.typeRoom,
    required this.floorRoom,
    required this.descriptionRoom,
    required this.pricePerNight,
    required this.statusRoom,
  });

  Color roomStatusColor(String status) {
    switch (status) {
      case 'متاح':
        return AppColors.green;
      case 'محجوز':
        return AppColors.warning;
      default:
        return AppColors.mainBlue;
    }
  }

  String roomStatusText(String status) {
    switch (status) {
      case 'متاح':
        return 'حجز الان';
      case 'محجوز':
        return 'تمديد الحجز';
      default:
        return 'تعديل الغرفة';
    }
  }
}
