import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/services/database_service.dart';
import 'package:palace_systeam_managment/features/customers/domin/entites/customer_entity.dart';
import 'package:palace_systeam_managment/features/customers/domin/repos/custmer_repo.dart';

import '../models/custmer_model.dart';

class CustmerRepoImpl extends CustmerRepo {
  final DatabaseService databaseService;

  CustmerRepoImpl({required this.databaseService});
  @override
  Future<Either<ApiErrorModel, void>> addNewCustmer({
    required CustomerEntity customerEntity,
  }) async {
    try {
      Map<String, dynamic> custmerData =
          CustmerModel.fromEntity(customerEntity).toMap();
      await databaseService.addData(
        path: 'custmers',
        data: custmerData,
        docId: customerEntity.nationalId,
      );
      log('custmer inserted successfully: $custmerData');
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> deleteCustmer({
    required CustomerEntity customerEntity,
  }) async {
    try {
      await databaseService.deleteData(
        path: 'custmers',
        supPath: customerEntity.nationalId,
      );
      log('custmer deleted successfully: ${customerEntity.nationalId}');
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, List<CustomerEntity>>> getAllCustmers() async {
    try {
      final custmersData = await databaseService.getData(path: 'custmers');
      List<CustomerEntity> custmers =
          (custmersData as List<dynamic>)
                  .map((data) => CustmerModel.fromMap(data))
                  .toList()
              as List<CustomerEntity>;
      return right(custmers);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> updateCustmer({
    required CustomerEntity customerEntity,
  }) async {
    try {
      Map<String, dynamic> custmer =
          CustmerModel.fromEntity(customerEntity).toMap();
      await databaseService.updateData(
        path: 'custmers',
        oldVALUE: {'nationalId': customerEntity.nationalId},
        supPath: customerEntity.nationalId,
        newVALUE: custmer,
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
