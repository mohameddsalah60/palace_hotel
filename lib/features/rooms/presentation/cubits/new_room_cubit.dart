// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:palace_systeam_managment/core/helpers/convert_arabic_to_english_numbers.dart';
// import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';

// import '../../domin/entites/room_entity.dart';

// part 'new_room_state.dart';

// class NewRoomCubit extends Cubit<NewRoomState> {
//   NewRoomCubit(this.newRoomRepo) : super(NewRoomInitial());
//   final NewRoomRepo newRoomRepo;
//   // Controllers and Form Key
//   final formKey = GlobalKey<FormState>();
//   final roomIdController = TextEditingController();
//   final typeRoomController = TextEditingController();
//   final floorRoomController = TextEditingController();
//   final descriptionRoomController = TextEditingController();
//   final priceController = TextEditingController();

//   // Dropdown Status
//   String selectedStatus = 'متاح';
//   final List<String> statuses = ['متاح', 'محجوز', 'تحت الصيانة'];

//   void setSelectedStatus(String? newStatus) {
//     if (newStatus != null) {
//       selectedStatus = newStatus;
//       emit(NewRoomInitial());
//     }
//   }

//   // معالجة البيانات بعد التحقق
//   void addNewRoom() async {
//     if (formKey.currentState!.validate()) {
//       emit(NewRoomLoading());
//       final roomEntity = RoomEntity(
//         roomId: convertArabicToEnglishNumbers(roomIdController.text),
//         typeRoom: typeRoomController.text,
//         floorRoom: floorRoomController.text,
//         descriptionRoom: descriptionRoomController.text,
//         pricePerNight: convertArabicToEnglishNumbers(priceController.text)!,
//         statusRoom: selectedStatus,
//       );
//       final result = await newRoomRepo.insertNewRoom(roomEntity: roomEntity);
//       result.fold(
//         (failure) {
//           emit(NewRoomFailure(errMessage: failure.errMessage));
//         },
//         (_) {
//           emit(NewRoomSuccess());
//           clearForm();
//         },
//       );
//     }
//   }

//   void clearForm() {
//     roomIdController.clear();
//     typeRoomController.clear();
//     floorRoomController.clear();
//     descriptionRoomController.clear();
//     priceController.clear();
//     selectedStatus = 'متاح';
//   }

//   onClose() {
//     clearForm();
//     emit(NewRoomInitial());
//   }
// }
