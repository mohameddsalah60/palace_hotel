import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<void> sendPasswordResetEmail({required String email});
}
