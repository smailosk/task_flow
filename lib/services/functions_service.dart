import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/failures/functions_failures.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/models/task/task.dart';

class FunctionsService {
  final _functions = FirebaseFunctions.instance;
  final _log = getLogger('FunctionsService');

  FunctionsService() {
    if (kDebugMode) {
      _functions.useFunctionsEmulator('localhost', 5001);
    }
  }

  Future<Map<String, dynamic>> _callCloudFunction(String functionName,
      {Map<String, dynamic>? data}) async {
    final callable = _functions.httpsCallable(
      functionName,
    );

    _log.i('Function: $functionName \n Payload: $data');

    try {
      _log.wtf(data);
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

  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final data = await _callCloudFunction('createTask', data: task.toJson());
      _log.wtf(data);
      return TaskModel.fromJson(data);
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description: 'FunctionsService - createTask ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future<void> markTaskDone(TaskModel task) async {
    try {
      await _callCloudFunction('markTaskDone', data: task.toJson());
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'FunctionsService - markTaskDone '
            '${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  Future updateTask(TaskModel taskModel) {
    try {
      return _callCloudFunction('updateTask', data: taskModel.toJson());
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description: 'FunctionsService - updateTask ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future deleteTask(TaskModel task) {
    try {
      return _callCloudFunction('deleteTask', data: task.toJson());
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description: 'FunctionsService - deleteTask ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future deleteProject(ProjectModel project) {
    try {
      return _callCloudFunction('deleteProject', data: project.toJson());
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'FunctionsService - deleteProject ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future editProject(ProjectModel project) {
    try {
      return _callCloudFunction('editProject', data: project.toJson());
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'FunctionsService - updateProject ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future editEnvironment(EnvironmentModel environmentModel) async {
    try {
      return _callCloudFunction('editEnvironment',
          data: environmentModel.toJson());
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'FunctionsService - editEnvironment ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future deleteEnvironment(String id) async {
    try {
      return _callCloudFunction('deleteEnvironment', data: {'id': id});
    } on FunctionsFailure {
      rethrow;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'FunctionsService - deleteEnvironment ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }
}
