import 'package:flutter/material.dart';

class RoomsFormController {
  final formKey = GlobalKey<FormState>();
  final roomIdController = TextEditingController();
  final descriptionRoomController = TextEditingController();
  final priceController = TextEditingController();

  int currntIndexFloor = 0;
  String selectedStatus = 'متاح';
  String selectedType = 'سينجل';
  String selectedFloorRoom = 'الاول';

  final List<String> statuses = ['متاح', 'تحت الصيانة', 'محجوز', 'هاوس'];
  final List<String> roomTypes = ['سينجل', 'دبل', 'جناح', 'سويت'];
  final List<String> roomFloors = [
    'الاول',
    'الثانى',
    'الثالث',
    'الرابع',
    'الخامس',
  ];

  void initFromRoom(dynamic room) {
    if (room == null) return;
    roomIdController.text = room.roomId?.toString() ?? '';
    selectedType = room.typeRoom ?? 'سينجل';
    selectedFloorRoom = room.floorRoom ?? '';
    descriptionRoomController.text = room.descriptionRoom ?? '';
    priceController.text = room.pricePerNight?.toString() ?? '';
    selectedStatus = room.statusRoom ?? 'متاح';
  }

  void clear() {
    roomIdController.clear();
    selectedFloorRoom = 'الاول';
    descriptionRoomController.clear();
    priceController.clear();
    selectedType = 'سينجل';
    selectedStatus = 'متاح';
  }

  void dispose() {
    roomIdController.dispose();
    descriptionRoomController.dispose();
    priceController.dispose();
    selectedFloorRoom = 'الاول';
    priceController.clear();
    selectedType = 'سينجل';
    selectedStatus = 'متاح';
  }
}
