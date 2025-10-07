import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/features/customers/domin/entites/customer_entity.dart';
import 'package:palace_systeam_managment/features/customers/domin/repos/custmer_repo.dart';

import '../../../../core/services/local_database.dart';
import '../models/custmer_model.dart';

class CustmerRepoImpl extends CustmerRepo {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<Either<ApiErrorModel, void>> addNewCustmer({
    required CustomerEntity customerEntity,
  }) async {
    try {
      Map<String, dynamic> custmerData =
          CustmerModel.fromEntity(customerEntity).toMap();
      await databaseHelper.insertData(table: 'custmers', row: custmerData);
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
      await databaseHelper.deleteData(
        table: 'custmers',
        id: customerEntity.nationalId,
        idColumn: 'nationalId',
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorModel, List<CustomerEntity>>> getAllCustmers() async {
    try {
      final custmersData = await databaseHelper.queryAllData(table: 'custmers');
      final custmers =
          custmersData.map((data) => CustmerModel.fromMap(data)).toList();
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
      await databaseHelper.updateData(
        row: custmer,
        table: 'custmers',
        id: customerEntity.nationalId,
        idColumn: 'nationalId',
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(DataBaseFailure(errMessage: e.toString()));
    }
  }
}
