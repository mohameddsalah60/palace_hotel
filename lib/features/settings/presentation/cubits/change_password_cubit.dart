import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/settings/domin/repo/change_password_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.changePasswordRepo) : super(ChangePasswordInitial());
  final ChangePasswordRepo changePasswordRepo;
  final formKey = GlobalKey<FormState>();
  final oldController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    final ruslt = await changePasswordRepo.changePasswordUser(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    ruslt.fold(
      (failure) {
        clearFildes();
        emit(ChangePasswordError(failure.errMessage));
      },
      (_) {
        clearFildes();
        emit(ChangePasswordSuccess());
      },
    );
  }

  clearFildes() {
    oldController.clear();
    newController.clear();
    confirmController.clear();
  }
}
