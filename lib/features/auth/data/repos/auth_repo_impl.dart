import 'package:dartz/dartz.dart';

import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/errors/error_messages.dart';
import 'package:palace_systeam_managment/core/errors/exceptions.dart';
import 'package:palace_systeam_managment/core/services/auth_service.dart';

import '../../domin/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService authService;

  AuthRepoImpl({required this.authService});
  @override
  Future<Either<ApiErrorModel, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await authService.sendPasswordResetEmail(email: email);

      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> signOut() async {
    try {
      await authService.signOut();

      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }
}
