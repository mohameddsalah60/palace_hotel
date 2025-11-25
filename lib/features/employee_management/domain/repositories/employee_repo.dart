import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';

import '../../../../core/entites/user_entity.dart';

abstract class EmployeeRepo {
  Future<Either<ApiErrorModel, void>> addEmployee(UserEntity employee);
  Future<Either<ApiErrorModel, void>> updateEmployee(UserEntity employee);

  Future<Either<ApiErrorModel, List<UserEntity>>> fetchEmployees();
  Future<Either<ApiErrorModel, void>> deleteEmployee(UserEntity employee);
}
