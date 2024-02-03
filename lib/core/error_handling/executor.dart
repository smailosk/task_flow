import 'package:dartz/dartz.dart';
import 'failure.dart';
import 'failures/general_failure.dart';

/// A class to reduce boilerplate for executing code and mapping failures
class Executor<T> {
  /// Executes the provided future and maps any failures to [Failure].
  ///
  /// - Parameter f: The future to execute.
  /// - Returns: A future that completes with either a [Failure] or the result of the future.
  static Future<Either<Failure, T>> run<T>(Future<T> f) => Task<T>(() => f)
      .attempt()
      .map((a) => a.leftMap((obj) {
            if (obj is Failure) {
              return obj;
            } else {
              return GeneralFailure(
                  type: GeneralFailureType.unexpectedError,
                  description: obj.toString(),
                  stackTrace: StackTrace.current);
            }
          }))
      .run();
}
