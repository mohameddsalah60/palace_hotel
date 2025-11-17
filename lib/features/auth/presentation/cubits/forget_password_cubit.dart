import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());
  final AuthRepo authRepo;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> sendPasswordResetEmail() async {
    emit(ForgetPasswordLoading());
    final result = await authRepo.sendPasswordResetEmail(
      email: emailController.text,
    );
    result.fold(
      (failure) {
        emit(ForgetPasswordFailure(message: failure.errMessage));
      },
      (_) {
        emit(ForgetPasswordSuccess());
      },
    );
  }
}
