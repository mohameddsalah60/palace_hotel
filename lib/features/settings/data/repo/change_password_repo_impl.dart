import 'package:dartz/dartz.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/helpers/get_user.dart';
import 'package:palace_systeam_managment/core/services/auth_service.dart';
import 'package:palace_systeam_managment/features/settings/domin/repo/change_password_repo.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/exceptions.dart';

class ChangePasswordRepoImpl extends ChangePasswordRepo {
  final AuthService authService;

  ChangePasswordRepoImpl({required this.authService});
  @override
  Future<Either<ApiErrorModel, void>> changePasswordUser({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await authService.changePassword(
        email: getUser().email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }
}
