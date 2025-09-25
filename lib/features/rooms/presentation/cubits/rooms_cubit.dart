import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/domin/entites/room_entity.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsCubit(this.roomsRepo, this.newRoomRepo) : super(RoomsInitial());

  final RoomsRepo roomsRepo;
  final NewRoomRepo newRoomRepo;

  List<RoomEntity> rooms = [];
  Timer? _debounce;
  List<RoomEntity> allRooms = [];

  // ============= Controllers and Form Key (New Room) ============
  final formKey = GlobalKey<FormState>();
  final roomIdController = TextEditingController();
  final typeRoomController = TextEditingController();
  final floorRoomController = TextEditingController();
  final descriptionRoomController = TextEditingController();
  final priceController = TextEditingController();

  // Dropdown Status for a new room
  String selectedStatus = 'متاح';
  final List<String> statuses = ['متاح', 'محجوز', 'تحت الصيانة'];

  String searchSelectedStatus = 'جميع الحالات';
  String searchSelectedType = 'جميع الأنواع';

  final List<String> searchStatuses = [
    'جميع الحالات',
    'متاح',
    'محجوز',
    'تحت الصيانة',
  ];

  final List<String> searchTypes = ['جميع الأنواع', 'سينجل', 'دبل', 'جناح'];

  void setSelectedStatus(String? newStatus) {
    if (newStatus != null && !isClosed) {
      selectedStatus = newStatus;
    }
  }

  void setSelectedSearchStatus(String? newStatus) {
    if (newStatus != null && !isClosed) {
      searchSelectedStatus = newStatus;
      _filterAndSearchRooms();
    }
  }

  void setSelectedSearchType(String? newType) {
    if (newType != null && !isClosed) {
      searchSelectedType = newType;
      _filterAndSearchRooms();
    }
  }

  void _filterAndSearchRooms() {
    if (isClosed) return;
    emit(RoomsLoading());

    List<RoomEntity> filteredRooms = allRooms;

    if (searchSelectedStatus != 'جميع الحالات') {
      filteredRooms =
          filteredRooms
              .where((room) => room.statusRoom == searchSelectedStatus)
              .toList();
    }

    if (searchSelectedType != 'جميع الأنواع') {
      filteredRooms =
          filteredRooms
              .where((room) => room.typeRoom == searchSelectedType)
              .toList();
    }

    final query = (roomIdController.text).trim().toLowerCase();
    if (query.isNotEmpty) {
      filteredRooms =
          filteredRooms.where((room) {
            return room.roomId!.toString().contains(query) ||
                room.typeRoom.toLowerCase().contains(query) ||
                room.statusRoom.toLowerCase().contains(query);
          }).toList();
    }

    rooms = filteredRooms;
    if (!isClosed) {
      emit(RoomsSuccess(rooms: rooms));
    }
  }

  void fetchRooms() async {
    if (isClosed) return;
    emit(RoomsLoading());

    final result = await roomsRepo.getAllRooms();

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(RoomsFailure(errMessage: failure.errMessage));
      },
      (fetchRooms) {
        allRooms = fetchRooms;
        rooms = allRooms;
        emit(RoomsSuccess(rooms: rooms));
      },
    );
  }

  void search(String query) {
    if (isClosed) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (isClosed) return;
      _filterAndSearchRooms();
    });
  }

  void addNewRoom() async {
    if (formKey.currentState!.validate()) {
      if (isClosed) return;

      final newRoomId = int.tryParse(roomIdController.text);

      if (newRoomId == null) {
        emit(RoomsFailure(errMessage: 'يرجى إدخال رقم غرفة صحيح.'));
        return;
      }

      emit(RoomsLoading());

      final roomEntity = RoomEntity(
        roomId: newRoomId,
        typeRoom: typeRoomController.text,
        floorRoom: floorRoomController.text,
        descriptionRoom: descriptionRoomController.text,
        pricePerNight: int.tryParse(priceController.text)!,
        statusRoom: selectedStatus,
      );
      final isRoomExists = allRooms.any((room) => room.roomId == newRoomId);
      if (isRoomExists) {
        updateRoom(roomEntity: roomEntity);
        fetchRooms();
        return;
      }

      final result = await newRoomRepo.insertNewRoom(roomEntity: roomEntity);

      if (isClosed) return;

      result.fold(
        (failure) {
          emit(RoomsFailure(errMessage: failure.errMessage));
        },
        (_) {
          clearForm();
          fetchRooms();
        },
      );
    }
  }

  void updateRoom({required RoomEntity roomEntity}) async {
    if (formKey.currentState!.validate()) {
      if (isClosed) return;

      final updatedRoomId = int.tryParse(roomIdController.text);

      if (updatedRoomId == null) {
        emit(RoomsFailure(errMessage: 'يرجى إدخال رقم غرفة صحيح.'));
        return;
      }

      emit(RoomsLoading());

      final result = await roomsRepo.updateRoom(roomEntity: roomEntity);

      if (isClosed) return;

      result.fold(
        (failure) {
          emit(RoomsFailure(errMessage: failure.errMessage));
        },
        (_) {
          clearForm();
          fetchRooms();
        },
      );
    }
  }

  void initialStartDialog(RoomEntity? room) {
    if (isClosed) return;
    // This ensures that the controllers are always updated with the new room data.
    roomIdController.text = room?.roomId.toString() ?? '';
    typeRoomController.text = room?.typeRoom ?? '';
    floorRoomController.text = room?.floorRoom ?? '';
    descriptionRoomController.text = room?.descriptionRoom ?? '';
    priceController.text = room?.pricePerNight.toString() ?? '';
    selectedStatus = room?.statusRoom ?? 'متاح';
  }

  void clearForm() {
    roomIdController.clear();
    typeRoomController.clear();
    floorRoomController.clear();
    descriptionRoomController.clear();
    priceController.clear();
    selectedStatus = 'متاح';
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    clearForm();
    return super.close();
  }
}
