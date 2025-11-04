part of 'extend_the_stay_cubit.dart';

abstract class ExtendTheStayState {}

class ExtendTheStayInitial extends ExtendTheStayState {}

class ExtendTheStayLoading extends ExtendTheStayState {}

class ExtendTheStaySuccess extends ExtendTheStayState {}

class ExtendTheStayError extends ExtendTheStayState {
  final String message;
  ExtendTheStayError(this.message);
}

class ExtendTheStaySummaryUpdated extends ExtendTheStayState {}
