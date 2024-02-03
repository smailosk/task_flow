import 'package:firebase_auth/firebase_auth.dart';

import '../failure.dart';

class FirebaseAuthFailure extends Failure {
  FirebaseAuthFailure(FirebaseAuthFailures type,
      {String? description, StackTrace? stackTrace, args})
      : super(type, description, stackTrace, args);

  static FirebaseAuthFailure mapFirebaseAuthExceptionToFailure(
      FirebaseAuthException exception) {
    switch (exception.code) {
      case "account-exists-with-different-credential":
        return FirebaseAuthFailure(
          FirebaseAuthFailures.accountExistsWithDifferentCredential,
          description: exception.message,
          stackTrace: exception.stackTrace,
          args: {
            "email": exception.email,
            "credential": exception.credential,
          },
        );
      case "invalid-credential":
        return FirebaseAuthFailure(FirebaseAuthFailures.invalidCredential,
            description: exception.message, stackTrace: exception.stackTrace);
      case "invalid-verification-code":
        return FirebaseAuthFailure(FirebaseAuthFailures.invalidVerificationCode,
            description: exception.message, stackTrace: exception.stackTrace);
      case "invalid-verification-id":
        return FirebaseAuthFailure(FirebaseAuthFailures.invalidVerificationId,
            description: exception.message, stackTrace: exception.stackTrace);
      case "operation-not-allowed":
        return FirebaseAuthFailure(FirebaseAuthFailures.operationNotAllowed,
            description: exception.message, stackTrace: exception.stackTrace);
      case "user-disabled":
        return FirebaseAuthFailure(FirebaseAuthFailures.userDisabled,
            description: exception.message, stackTrace: exception.stackTrace);
      case "user-not-found":
        return FirebaseAuthFailure(FirebaseAuthFailures.userNotFound,
            description: exception.message, stackTrace: exception.stackTrace);
      case "wrong-password":
        return FirebaseAuthFailure(FirebaseAuthFailures.wrongPassword,
            description: exception.message, stackTrace: exception.stackTrace);
      case "email-already-in-use":
        return FirebaseAuthFailure(FirebaseAuthFailures.emailAlreadyInUse,
            description: exception.message, stackTrace: exception.stackTrace);
      case "invalid-email":
        return FirebaseAuthFailure(FirebaseAuthFailures.invalidEmail,
            description: exception.message, stackTrace: exception.stackTrace);
      case "weak-password":
        return FirebaseAuthFailure(FirebaseAuthFailures.weakPassword,
            description: exception.message, stackTrace: exception.stackTrace);
      default:
        return FirebaseAuthFailure(FirebaseAuthFailures.unknown,
            description: exception.message, stackTrace: exception.stackTrace);
    }
  }
}

enum FirebaseAuthFailures {
  accountExistsWithDifferentCredential,
  invalidCredential,
  operationNotAllowed,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidVerificationCode,
  invalidVerificationId,
  unknown,
  emailAlreadyInUse,
  invalidEmail,
  weakPassword,
  userMismatch,
  requiresRecentLogin,
}
