import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/errors/exceptions.dart';
import 'package:palace_systeam_managment/core/services/auth_service.dart';
import 'package:palace_systeam_managment/core/services/database_service.dart';
import 'package:palace_systeam_managment/core/models/user_model.dart';
import 'package:palace_systeam_managment/core/entites/user_entity.dart';
import '../../../../core/errors/error_messages.dart';
import '../../domain/repositories/employee_repo.dart';

class EmployeeRepoImpl implements EmployeeRepo {
  final DatabaseService databaseService;
  final AuthService authService;
  EmployeeRepoImpl({required this.databaseService, required this.authService});

  @override
  Future<Either<ApiErrorModel, void>> addEmployee(UserEntity employee) async {
    try {
      if (await databaseService.checkIfDataExists(
        path: 'users',
        docId: employee.email,
      )) {
        return Left(ServerFailure(errMessage: 'هذا الموظف موجود من قبل'));
      } else {
        await authService.createUserWithEmailAndPassword(
          email: employee.email,
          password: '123456',
        );
        UserModel user = UserModel.fromEntity(employee);
        await databaseService.addData(
          path: 'users',
          docId: employee.email,
          data: user.toMap(),
        );
      }
      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, List<UserEntity>>> fetchEmployees() async {
    try {
      final usersData = await databaseService.getData(path: 'users');
      List<UserEntity> users =
          (usersData as List<dynamic>)
                  .map((data) => UserModel.fromJsonData(data))
                  .toList()
              as List<UserEntity>;
      return right(users);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> deleteEmployee(
    UserEntity employee,
  ) async {
    try {
      await authService.deleteAccount();
      await databaseService.deleteData(path: 'users', value: employee.email);
      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> updateEmployee(
    UserEntity employee,
  ) async {
    try {
      if (!await databaseService.checkIfDataExists(
        path: 'users',
        docId: employee.email,
      )) {
        return Left(ServerFailure(errMessage: 'هذا الموظف غير موجود من قبل'));
      } else {
        UserModel user = UserModel.fromEntity(employee);
        await databaseService.addData(
          path: 'users',
          docId: employee.email,
          data: user.toMap(),
        );
      }
      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }
}
