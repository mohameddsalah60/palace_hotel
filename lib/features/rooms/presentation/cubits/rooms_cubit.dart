import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';

import 'rooms_filter_helper.dart';
import 'rooms_form_controller.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsCubit(this.roomsRepo, this.newRoomRepo) : super(RoomsInitial());

  final RoomsRepo roomsRepo;
  final NewRoomRepo newRoomRepo;

  final formController = RoomsFormController();

  List<RoomEntity> allRooms = [];
  List<RoomEntity> rooms = [];

  Timer? _debounce;
  StreamSubscription? _streamSubscription;

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
  void _applyFilters({String query = ''}) {
    if (isClosed) return;
    emit(RoomsLoading());

    rooms = RoomsFilterHelper.apply(
      allRooms: allRooms,
      selectedFloor: selectedFloor,
      searchSelectedStatus: searchSelectedStatus,
      searchSelectedType: searchSelectedType,
      searchQuery: query.trim(),
    );

    emit(RoomsSuccess(rooms: rooms));
  }

  // ==================== Search ====================
  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => _applyFilters(query: query),
    );
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

  Future<void> fetchRooms() async {
    emit(RoomsLoading());

    try {
      _streamSubscription = roomsRepo.getAllRooms().listen((result) {
        result.fold(
          (failure) => emit(RoomsFailure(errMessage: failure.errMessage)),
          (fetchedRooms) {
            allRooms = fetchedRooms;
            rooms = allRooms;
            emit(RoomsSuccess(rooms: rooms));
          },
        );
      });
    } catch (e) {
      emit(RoomsFailure(errMessage: e.toString()));
    }
  }

  Future<void> addNewRoom() async {
    if (!formController.formKey.currentState!.validate()) return;

    emit(RoomsLoading());

    try {
      final id = int.tryParse(formController.roomIdController.text);
      if (id == null) throw Exception('يرجى إدخال رقم غرفة صحيح.');

      final entity = RoomEntity(
        roomId: id,
        typeRoom: formController.selectedType,
        floorRoom: formController.selectedFloorRoom,
        descriptionRoom: formController.descriptionRoomController.text,
        pricePerNight: int.tryParse(formController.priceController.text) ?? 0,
        statusRoom: formController.selectedStatus,
      );

      final result = await newRoomRepo.insertNewRoom(roomEntity: entity);
      result.fold(
        (failure) => emit(RoomsFailure(errMessage: failure.errMessage)),
        (_) async {
          formController.clear();
          log('Room added: $entity');
          await fetchRooms(); // تحديث القوائم بعد الإضافة
        },
      );
    } catch (e) {
      emit(RoomsFailure(errMessage: e.toString()));
    }
  }

  Future<void> deleteRoom(RoomEntity room) async {
    if (room.statusRoom == 'محجوز') {
      emit(RoomsFailure(errMessage: 'لا يمكن حذف غرفة محجوزة.'));
      return;
    }

    emit(RoomsLoading());
    try {
      final result = await roomsRepo.deleteRoom(roomEntity: room);
      result.fold(
        (failure) => emit(RoomsFailure(errMessage: failure.errMessage)),
        (_) => fetchRooms(),
      );
    } catch (e) {
      emit(RoomsFailure(errMessage: e.toString()));
    }
  }

  int countRoomsByStatus(String status) {
    try {
      return allRooms.where((room) => room.statusRoom == status).length;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
