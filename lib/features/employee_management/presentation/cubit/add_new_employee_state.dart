part of 'add_new_employee_cubit.dart';

sealed class AddNewEmployeeState {}

final class AddNewEmployeeInitial extends AddNewEmployeeState {}

final class AddNewEmployeeLoading extends AddNewEmployeeState {}

final class AddNewEmployeeSuccess extends AddNewEmployeeState {}

final class AddNewEmployeeFailure extends AddNewEmployeeState {
  final String message;
  AddNewEmployeeFailure({required this.message});
}

final class UpdateUI extends AddNewEmployeeState {}
