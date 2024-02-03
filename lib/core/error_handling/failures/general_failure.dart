import '../failure.dart';

class GeneralFailure extends Failure {
  GeneralFailure(
      {GeneralFailureType type = GeneralFailureType.unexpectedError,
      String description = '',
      StackTrace stackTrace = StackTrace.empty,
      args})
      : super(type, description, stackTrace, args);
}

enum GeneralFailureType {
  internetConnectionError,
  unexpectedError,
  formatError,
  socketException,
  noSuchMethodError,
  platformError,
  unsupportedType,
  jsonConversionError,
  httpException
}
