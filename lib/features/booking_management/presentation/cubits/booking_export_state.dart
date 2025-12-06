part of 'booking_export_cubit.dart';

abstract class BookingExportState {
  const BookingExportState();
}

class BookingExportInitial extends BookingExportState {}

class BookingExportLoading extends BookingExportState {}

class BookingExportSuccess extends BookingExportState {}

class BookingExportFailure extends BookingExportState {
  final String error;
  const BookingExportFailure({required this.error});
}
