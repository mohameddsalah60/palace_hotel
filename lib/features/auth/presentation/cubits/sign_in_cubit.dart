import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.signInRepo) : super(SignInInitial());
  final AuthRepo signInRepo;
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    emit(SignInLoading());
    final result = await signInRepo.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );

    result.fold(
      (failure) {
        emit(SignInFailure(message: failure.errMessage));
      },
      (_) {
        emit(SignInSucsses());
      },
    );
  }
}
