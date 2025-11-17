abstract class ApiErrorModel {
  final String errMessage;
  final String? code;

  const ApiErrorModel({required this.errMessage, this.code});
}

class NetworkFailure extends ApiErrorModel {
  const NetworkFailure({required super.errMessage, super.code});
}

class ServerFailure extends ApiErrorModel {
  const ServerFailure({required super.errMessage, super.code});
}

class CacheFailure extends ApiErrorModel {
  const CacheFailure({required super.errMessage, super.code});
}

class DataBaseFailure extends ApiErrorModel {
  const DataBaseFailure({required super.errMessage, super.code});
}

class AuthFailure extends ApiErrorModel {
  const AuthFailure({required super.errMessage, super.code});
}

class UnknownFailure extends ApiErrorModel {
  const UnknownFailure({required super.errMessage, super.code});
}
