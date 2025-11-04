part of 'booking_room_cubit.dart';

@immutable
sealed class BookingRoomState {}

final class BookingRoomInitial extends BookingRoomState {}

final class BookingRoomLoading extends BookingRoomState {}

final class BookingRoomSuccess extends BookingRoomState {}

final class UpdateStateBooking extends BookingRoomState {}

final class DeleteBooking extends BookingRoomState {}

final class BookingGetDataSuccess extends BookingRoomState {
  final List<BookingEntity> bookings;
  BookingGetDataSuccess({required this.bookings});
}

final class BookingRoomError extends BookingRoomState {
  final String message;
  BookingRoomError({required this.message});
}
