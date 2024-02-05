import 'package:cloud_functions/cloud_functions.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/failures/functions_failures.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/core/models/project/project.dart';

class FunctionsService {
  final _functions = FirebaseFunctions.instance;
  final _log = getLogger('FunctionsService');
  FunctionsService() {
    _functions.useFunctionsEmulator('localhost', 5001);
  }

  Future<Map<String, dynamic>> _callCloudFunction(String functionName,
      {Map<String, dynamic>? data}) async {
    final callable = _functions.httpsCallable(
      functionName,
    );

    _log.i('Function: $functionName \n Payload: $data');

    try {
      final result = await callable(data);
      var response = result.data as Map<String, dynamic>;

      return response;
    } on FirebaseFunctionsException catch (e) {
      throw FunctionsFailure.mapFirebaseAuthExceptionToFailure(e);
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description: "functionName: $functionName ${exception.toString()}",
          stackTrace: stackTrace);
    }
  }

  Future<EnvironmentModel> createEnvironment(
      EnvironmentModel environment) async {
    try {
      final data = await _callCloudFunction('createEnvironment',
          data: environment.toJson());

      return EnvironmentModel.fromJson(data);
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'FunctionsService - createEnvironment ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future<ProjectModel> createProject(ProjectModel project) async {
    try {
      final data =
          await _callCloudFunction('createProject', data: project.toJson());
      _log.wtf(data);
      return ProjectModel.fromJson(data);
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'FunctionsService - createProject ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }
}
