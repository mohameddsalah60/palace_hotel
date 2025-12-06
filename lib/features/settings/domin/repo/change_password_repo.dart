import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';

abstract class ChangePasswordRepo {
  Future<Either<ApiErrorModel, void>> changePasswordUser({
    required String oldPassword,
    required String newPassword,
  });
}
