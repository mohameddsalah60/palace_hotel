part of 'rooms_cubit.dart';

sealed class RoomsState {}

final class RoomsInitial extends RoomsState {}

final class RoomsLoading extends RoomsState {}

final class RoomsSuccess extends RoomsState {
  final List<RoomEntity> rooms;

  RoomsSuccess({required this.rooms});
}

final class RoomsFailure extends RoomsState {
  final String errMessage;
  RoomsFailure({required this.errMessage});
}
