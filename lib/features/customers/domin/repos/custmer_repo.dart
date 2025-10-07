import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/features/customers/domin/entites/customer_entity.dart';

abstract class CustmerRepo {
  Future<Either<ApiErrorModel, void>> addNewCustmer({
    required CustomerEntity customerEntity,
  });
  Future<Either<ApiErrorModel, void>> updateCustmer({
    required CustomerEntity customerEntity,
  });
  Future<Either<ApiErrorModel, void>> deleteCustmer({
    required CustomerEntity customerEntity,
  });
  Future<Either<ApiErrorModel, List<CustomerEntity>>> getAllCustmers();
}
