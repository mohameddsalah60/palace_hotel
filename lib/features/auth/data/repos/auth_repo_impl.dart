import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:palace_systeam_managment/core/errors/api_error_model.dart';
import 'package:palace_systeam_managment/core/errors/error_messages.dart';
import 'package:palace_systeam_managment/core/errors/exceptions.dart';
import 'package:palace_systeam_managment/core/services/auth_service.dart';
import 'package:palace_systeam_managment/core/services/database_service.dart';
import 'package:palace_systeam_managment/core/models/user_model.dart';
import 'package:palace_systeam_managment/core/entites/user_entity.dart';

import '../../../../core/services/shared_preferences_service.dart';
import '../../../../core/entites/permissions_users.dart';
import '../../domin/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService authService;
  final DatabaseService databaseService;

  AuthRepoImpl({required this.databaseService, required this.authService});
  @override
  Future<Either<ApiErrorModel, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      bool userExists = await databaseService.checkIfDataExists(
        path: 'users',
        docId: user.email!,
      );
      if (userExists) {
        await getCurrentUser(email: email);
      } else {
        UserEntity userEntity = UserEntity(
          name: user.displayName ?? '',
          phone: user.phoneNumber ?? '',
          email: email,
          token: user.uid,
          nid: '',
          jopTitle: '',
          permissions: PermissionsUsers(
            canAddRoom: false,
            canEditRoom: false,
            canDeleteRoom: false,
            canViewRooms: false,
            canAddDiscountOver20: false,
            canCreateBooking: false,
            canEditBooking: false,
            canCancelBooking: false,
            canCloseBooking: false,
            canViewBookings: false,
            canAddGuest: false,
            canEditGuest: false,
            canDeleteGuest: false,
            canViewGuests: false,
            canAddStaff: false,
            canEditStaff: false,
            canDeleteStaff: false,
            canViewStaff: false,
            canViewInvoices: false,
            canEditInvoices: false,
            canDeleteInvoices: false,
            canCreateInvoice: false,
            canManageServices: false,
            canChangeSettings: false,
            canViewReports: false,
          ),
        );
        await databaseService.addData(
          path: 'users',
          docId: user.email,
          data: UserModel.fromEntity(userEntity).toMap(),
        );
        final userModel = UserModel.fromJsonData(
          UserModel.fromEntity(userEntity).toMap(),
        );
        SharedPreferencesService.setData(
          key: 'currentUser',
          value: userModel.toMap(),
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
      await SharedPreferencesService.remove('currentUser');
      return right(null);
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }

  Future<Either<ApiErrorModel, void>> getCurrentUser({
    required String email,
  }) async {
    try {
      final userData = await databaseService.getData(path: 'users', uId: email);
      if (userData != null) {
        log('userData: $userData');
        final userModel = UserModel.fromJsonData(userData);
        SharedPreferencesService.setData(
          key: 'currentUser',
          value: jsonEncode(userModel.toMap()),
        );
        return right(null);
      } else {
        return right(null);
      }
    } on CustomException catch (e) {
      return left(AppErrorManager.handle(e));
    } catch (e) {
      return left(AppErrorManager.handle(e));
    }
  }
}
