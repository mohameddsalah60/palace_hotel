part of 'page_changed_cubit.dart';

sealed class PageChangedState {}

final class PageChangedInitial extends PageChangedState {}

final class PageChangedSuccess extends PageChangedState {}

final class PageChangedLogoutLoading extends PageChangedState {}

final class PageChangedLogoutSuccess extends PageChangedState {}

final class PageChangedLogoutFailure extends PageChangedState {
  final String message;
  PageChangedLogoutFailure({required this.message});
}
