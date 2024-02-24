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
                  description: 'Executor expects failures to be thrown! \n$obj',
                  stackTrace: StackTrace.current);
            }
          }))
      .run();
}

extension ExecutorFutureExtension<T> on Future<T> {
  Future<void> executeFuture(
      void Function(Failure) onError, void Function(T) onSuccess) async {
    Executor.run(this).then((value) => value.fold(onError, onSuccess));
  }
}
