part of 'custmers_cubit.dart';

sealed class CustmersState {}

final class CustmersInitial extends CustmersState {}

final class CustmersLoading extends CustmersState {}

final class CustmersLoaded extends CustmersState {
  final List<CustomerEntity> custmers;
  CustmersLoaded(this.custmers);
}

final class CustmersError extends CustmersState {
  final String message;
  CustmersError(this.message);
}

final class CustmerAdded extends CustmersState {}

final class CustmerUpdated extends CustmersState {}

final class CustmerDeleted extends CustmersState {}
