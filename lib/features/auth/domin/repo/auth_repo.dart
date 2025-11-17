import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';

abstract class AuthRepo {
  Future<Either<ApiErrorModel, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<ApiErrorModel, void>> signOut();
  Future<Either<ApiErrorModel, void>> sendPasswordResetEmail({
    required String email,
  });
}
