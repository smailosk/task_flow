import 'package:flutter/services.dart';
import 'package:task_flow/core/error_handling/failure.dart';

class GoogleAuthFailure extends Failure {
  GoogleAuthFailure(GoogleAuthFailureType type,
      {String? description, StackTrace? stackTrace, args})
      : super(type, description, stackTrace, args);

  static GoogleAuthFailure mapFirebaseAuthExceptionToFailure(
      PlatformException exception) {
    final stackTrace = StackTrace.fromString(exception.stacktrace ?? '');
    switch (exception.code) {
      case "network_error":
        return GoogleAuthFailure(GoogleAuthFailureType.networkError,
            description: exception.message, stackTrace: stackTrace);
      case "sign_in_canceled":
        return GoogleAuthFailure(GoogleAuthFailureType.canceled,
            description: exception.message, stackTrace: stackTrace);
      case "sign_in_failed":
        return GoogleAuthFailure(GoogleAuthFailureType.signInFailed,
            description: exception.message, stackTrace: stackTrace);
      case "sign_in_required":
        return GoogleAuthFailure(GoogleAuthFailureType.signInRequired,
            description: exception.message, stackTrace: stackTrace);
      default:
        return GoogleAuthFailure(GoogleAuthFailureType.unknown,
            description: exception.message, stackTrace: stackTrace);
    }
  }
}

enum GoogleAuthFailureType {
  signInFailed,
  networkError,
  canceled,
  signInRequired,
  unknown
}
