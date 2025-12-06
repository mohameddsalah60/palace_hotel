import 'package:firebase_auth/firebase_auth.dart';
import 'package:palace_systeam_managment/core/errors/api_error_model.dart';

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    try {
      return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() {
    try {
      return FirebaseAuth.instance.currentUser!.delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final cred = EmailAuthProvider.credential(
        email: email,
        password: oldPassword,
      );
      if (user == null) {
        return AuthFailure(
          errMessage: 'لقد حصل خطآ ما، الرجاء المحاولة مرة اخرى',
        );
      }
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }
}
