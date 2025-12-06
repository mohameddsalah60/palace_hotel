import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<void> deleteAccount();
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });
}
