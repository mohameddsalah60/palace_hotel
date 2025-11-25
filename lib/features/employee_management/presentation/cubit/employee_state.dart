import 'package:palace_systeam_managment/core/entites/user_entity.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<UserEntity> employees;

  EmployeeLoaded({required this.employees});
}

class EmployeeSuccess extends EmployeeState {}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError(this.message);
}
