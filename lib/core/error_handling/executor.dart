import 'package:dartz/dartz.dart';
import 'failure.dart';
import 'failures/general_failure.dart';

/// A class to reduce boilerplate for executing code and mapping failures
class Executor<T> {
  /// Executes the provided future and maps any failures to [Failure].
  ///
  /// - Parameter f: The future to execute.
  /// - Returns: A future that completes with either a [Failure] or the result of the future.
  static Future<Either<Failure, T>> runFuture<T>(Future<T> f) {
    return Task<T>(() => f)
        .attempt()
        .map((a) => a.leftMap((obj) {
              if (obj is Failure) {
                return obj;
              } else {
                return GeneralFailure(
                    type: GeneralFailureType.unexpectedError,
                    description:
                        'Executor expects failures to be thrown! \n$obj',
                    stackTrace: StackTrace.current);
              }
            }))
        .run();
  }

  static Either<Failure, T> runSync<T>(T Function() f) {
    try {
      final result = f();

      return right(result);
    } on Failure catch (error) {
      return left(error);
    } catch (error, stackTrace) {
      return left(GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'Executor expects failures to be thrown! \n$error',
        stackTrace: stackTrace,
      ));
    }
  }
}

extension ExecutorFutureExtension<T> on Future<T> {
  Future<void> executeFuture(
      void Function(Failure) onError, void Function(T) onSuccess) async {
    Executor.runFuture(this).then((value) => value.fold(onError, onSuccess));
  }
}

// extension ExecutorSyncExtension<R> on R {
//   Either<Failure, R> runSync(
//           void Function(Failure) onError, void Function(R) onSuccess) =>

// }
extension ExecutorSyncExtension<T> on T {
  void runSync(void Function(Failure) onError, T Function(T) onSuccess) {
    Executor.runSync(() => this).fold(onError, onSuccess);
  }
}
