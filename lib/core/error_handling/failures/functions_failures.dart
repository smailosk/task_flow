import 'package:cloud_functions/cloud_functions.dart';
import 'package:task_flow/core/error_handling/failure.dart';

class FunctionsFailure extends Failure {
  FunctionsFailure(FunctionsFailureType type,
      {String? description, StackTrace? stackTrace, args})
      : super(type, description, stackTrace, args);

  static FunctionsFailure mapFirebaseAuthExceptionToFailure(
      FirebaseFunctionsException exception) {
    switch (exception.code) {
      case 'ok':
        return FunctionsFailure(FunctionsFailureType.ok,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'cancelled':
        return FunctionsFailure(FunctionsFailureType.cancelled,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'unknown':
        return FunctionsFailure(FunctionsFailureType.unknown,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'invalid-argument':
        return FunctionsFailure(FunctionsFailureType.invalidArgument,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'deadline-exceeded':
        return FunctionsFailure(FunctionsFailureType.deadlineExceeded,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'not-found':
        return FunctionsFailure(FunctionsFailureType.notFound,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'already-exists':
        return FunctionsFailure(FunctionsFailureType.alreadyExists,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'permission-denied':
        return FunctionsFailure(FunctionsFailureType.permissionDenied,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'resource-exhausted':
        return FunctionsFailure(FunctionsFailureType.resourceExhausted,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'failed-precondition':
        return FunctionsFailure(FunctionsFailureType.failedPrecondition,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'aborted':
        return FunctionsFailure(FunctionsFailureType.aborted,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'out-of-range':
        return FunctionsFailure(FunctionsFailureType.outOfRange,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'unimplemented':
        return FunctionsFailure(FunctionsFailureType.unimplemented,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'internal':
        return FunctionsFailure(FunctionsFailureType.internal,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'unavailable':
        return FunctionsFailure(FunctionsFailureType.unavailable,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'data-loss':
        return FunctionsFailure(FunctionsFailureType.dataLoss,
            description: exception.message, stackTrace: exception.stackTrace);
      case 'unauthenticated':
        return FunctionsFailure(FunctionsFailureType.unauthenticated,
            description: exception.message, stackTrace: exception.stackTrace);
      default:
        return FunctionsFailure(FunctionsFailureType.unknown,
            description: exception.message, stackTrace: exception.stackTrace);
    }
  }
}

enum FunctionsFailureType {
  ok,
  cancelled,
  unknown,
  invalidArgument,
  deadlineExceeded,
  notFound,
  alreadyExists,
  permissionDenied,
  resourceExhausted,
  failedPrecondition,
  aborted,
  outOfRange,
  unimplemented,
  internal,
  unavailable,
  dataLoss,
  unauthenticated,
}
