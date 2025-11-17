import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'api_error_model.dart';

class AppErrorManager {
  static ApiErrorModel handle(dynamic error) {
    if (kDebugMode) {
      print("Handling error: $error");
    }

    // ---------------- Firebase Auth Errors ----------------
    if (error is FirebaseAuthException) {
      return AuthFailure(
        errMessage: _authMessage(error.code),
        code: error.code,
      );
    }

    // ---------------- Firestore / Storage ----------------
    if (error is FirebaseException) {
      return DataBaseFailure(
        errMessage: _firebaseMessage(error.code),
        code: error.code,
      );
    }

    // ---------------- Socket / Internet ----------------
    if (error is SocketException) {
      return NetworkFailure(
        errMessage: "لا يوجد اتصال بالإنترنت",
        code: "no-internet",
      );
    }

    // ---------------- Timeout ----------------
    if (error is TimeoutException) {
      return NetworkFailure(
        errMessage: "انتهت مهلة الاتصال، حاول مرة أخرى",
        code: "timeout",
      );
    }

    // ---------------- Unknown ----------------
    return UnknownFailure(
      errMessage: "حدث خطأ غير متوقع: ${error.toString()}",
      code: "unknown",
    );
  }

  // ---------------- Firebase Auth Messages ----------------
  static String _authMessage(String code) {
    switch (code) {
      // Network
      case 'network-request-failed':
        return "تحقق من اتصالك بالإنترنت.";

      // Email / Password
      case 'invalid-email':
        return "البريد الإلكتروني غير صالح.";
      case 'user-disabled':
        return "تم تعطيل حساب المستخدم.";
      case 'user-not-found':
        return "لا يوجد مستخدم بهذا البريد.";
      case 'wrong-password':
        return "البريد الإلكتروني أو كلمة المرور غير صحيحة.";
      case 'email-already-in-use':
        return "هذا البريد مستخدم بالفعل.";
      case 'weak-password':
        return "كلمة المرور ضعيفة جداً.";
      case 'invalid-credential':
        return "بيانات تسجيل الدخول غير صحيحة.";
      case 'too-many-requests':
        return "عدد محاولات تسجيل الدخول كبير جداً. حاول لاحقاً.";

      // OTP / Phone
      case 'invalid-verification-code':
        return "رمز التحقق غير صحيح.";
      case 'invalid-verification-id':
        return "معرف التحقق غير صالح.";

      // Others
      case 'account-exists-with-different-credential':
        return "هناك حساب مسجل بطريقة مختلفة.";
      case 'operation-not-allowed':
        return "هذا النوع من تسجيل الدخول غير مفعّل.";

      default:
        return "حدث خطأ أثناء تسجيل الدخول، حاول مرة أخرى.";
    }
  }

  // ---------------- Firebase Database Messages ----------------
  static String _firebaseMessage(String code) {
    switch (code) {
      case "permission-denied":
        return "لا تملك صلاحية الوصول.";
      case "not-found":
        return "العنصر المطلوب غير موجود.";
      case "unavailable":
        return "الخدمة غير متاحة حالياً.";
      default:
        return "حدث خطأ أثناء التعامل مع البيانات.";
    }
  }
}
