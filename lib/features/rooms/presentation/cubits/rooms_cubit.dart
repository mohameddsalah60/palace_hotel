import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';

import 'rooms_filter_helper.dart';
import 'rooms_form_controller.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsCubit(this.roomsRepo, this.newRoomRepo) : super(RoomsInitial()) {
    fetchRooms();
  }

  final RoomsRepo roomsRepo;
  final NewRoomRepo newRoomRepo;

  final formController = RoomsFormController();

  List<RoomEntity> allRooms = [];
  List<RoomEntity> rooms = [];

  Timer? _debounce;

  List<String> floors = [
    'الكل',
    'الاول',
    'الثانى',
    'الثالث',
    'الرابع',
    'الخامس',
  ];
  String selectedFloor = 'الكل';
  String searchSelectedStatus = 'جميع الحالات';
  String searchSelectedType = 'جميع الأنواع';
  final List<String> searchStatuses = [
    'جميع الحالات',
    'متاح',
    'محجوز',
    'تحت الصيانة',
  ];
  final List<String> searchTypes = ['جميع الأنواع', 'سينجل', 'دبل', 'جناح'];

  // ==================== Filtering ====================
  void _applyFilters() {
    if (isClosed) return;
    emit(RoomsLoading());

    rooms = RoomsFilterHelper.apply(
      allRooms: allRooms,
      selectedFloor: selectedFloor,
      searchSelectedStatus: searchSelectedStatus,
      searchSelectedType: searchSelectedType,
      searchQuery: formController.roomIdController.text.trim(),
    );

    emit(RoomsSuccess(rooms: rooms));
  }

  // ==================== Search ====================
  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _applyFilters);
  }

  // ==================== Setters ====================
  void setSelectedFloor(String floor) {
    selectedFloor = floor;
    _applyFilters();
  }

  void setSelectedSearchStatus(String? newStatus) {
    if (newStatus == null) return;
    searchSelectedStatus = newStatus;
    _applyFilters();
  }

  void setSelectedSearchType(String? newType) {
    if (newType == null) return;
    searchSelectedType = newType;
    _applyFilters();
  }

  // ==================== CRUD ====================
  Future<void> fetchRooms() async {
    emit(RoomsLoading());
    final result = await roomsRepo.getAllRooms();

    result.fold(
      (failure) => emit(RoomsFailure(errMessage: failure.errMessage)),
      (data) {
        allRooms = data;
        rooms = allRooms;
        emit(RoomsSuccess(rooms: rooms));
      },
    );
  }

  Future<void> addNewRoom() async {
    final form = formController;
    if (!form.formKey.currentState!.validate()) return;

    final id = int.tryParse(form.roomIdController.text);
    if (id == null) {
      emit(RoomsFailure(errMessage: 'يرجى إدخال رقم غرفة صحيح.'));
      return;
    }

    final entity = RoomEntity(
      roomId: id,
      typeRoom: form.selectedType,
      floorRoom: form.selectedFloorRoom,
      descriptionRoom: form.descriptionRoomController.text,
      pricePerNight: int.tryParse(form.priceController.text)!,
      statusRoom: form.selectedStatus,
    );

    emit(RoomsLoading());

    final exists = allRooms.any((r) => r.roomId == id);
    final result =
        exists
            ? await roomsRepo.updateRoom(roomEntity: entity)
            : await newRoomRepo.insertNewRoom(roomEntity: entity);

    result.fold(
      (failure) => emit(RoomsFailure(errMessage: failure.errMessage)),
      (_) {
        form.clear();
        fetchRooms();
      },
    );
  }

  Future<void> deleteRoom(RoomEntity room) async {
    if (room.statusRoom == 'محجوز') {
      emit(RoomsFailure(errMessage: 'لا يمكن حذف غرفة محجوزة.'));
      return;
    }
    final result = await roomsRepo.deleteRoom(roomEntity: room);
    result.fold(
      (failure) => emit(RoomsFailure(errMessage: failure.errMessage)),
      (_) => fetchRooms(),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    formController.dispose();
    return super.close();
  }
}
