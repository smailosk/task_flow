import 'package:stacked/stacked.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/failure.dart';
import 'package:task_flow/core/error_handling/failures/functions_failures.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/firestore_service.dart';
import 'package:task_flow/services/functions_service.dart';

class RepoService with ListenableServiceMixin {
  final _firestore = locator<FirestoreService>();
  final _functions = locator<FunctionsService>();
  final _log = getLogger('RepoService');

  final Map<String, EnvironmentModel> _environments = {};
  final Map<String, ProjectModel> _projects = {};
  final Map<String, List<TaskModel>> _tasksByProject = {};

  Map<String, EnvironmentModel> get environments => _environments;
  Map<String, ProjectModel> get projects => _projects;
  Map<String, List<TaskModel>> get tasksByProject => _tasksByProject;

  init() async {
    _environments.clear();
    _projects.clear();

    _log.i('RepoService - init');
    await _fetchEnvironments();
    final envToFetch = await _fetchProjects();
    await _fetchEnvironmentByIds(envToFetch);

    _log.i('RepoService - init - _environments: ${_environments.length}');
    _log.i('RepoService - init - _projects: ${_projects.length}');
    _log.i('RepoService - init - done');
    notifyListeners();
    _log.i(_environments.values.first.color);
  }

  _fetchEnvironments() async {
    try {
      final data = await _firestore.fetchEnvironments();
      final envs = {for (var e in data) e.id: e};
      _environments.addAll(envs);
    } on Failure catch (e) {
      _log.e('RepoService - _fetchEnvironment', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - _fetchEnvironment ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  Future<List<String>> _fetchProjects() async {
    try {
      final data = await _firestore.fetchProjects();

      final projects = {for (var e in data) e.id: e};
      _projects.addAll(projects);
      return data.map((e) => e.parentEnvironmentId).toList();
    } on Failure catch (e) {
      _log.e('RepoService - _fetchProjects', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - _fetchProjects ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  _fetchEnvironmentByIds(List<String> ids) async {
    try {
      final data = await _firestore.fetchEnvironmentsByIds(ids);

      final envs = {for (var e in data) e.id: e};
      _environments.addAll(envs);
    } on Failure catch (e) {
      _log.e('RepoService - _fetchEnvironmentByIds', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - _fetchEnvironmentByIds ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  Future<List<TaskModel>> fetchTasksForProject(String projectId) async {
    try {
      final data = await _firestore.fetchTasksForProject(projectId);
      _tasksByProject[projectId] = data + data + data;
      return data;
    } on Failure catch (e) {
      _log.e('RepoService - fetchTasksForProject', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - fetchTasksForProject ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  // _fetchProjectsByIds(List<String> ids) async {
  //   try {
  //     final data = await _firestore.fetchProjectsByIds(ids);
  //     _projects.addAll(data);
  //   } on Failure catch (e) {
  //     _log.e('RepoService - _fetchProjectsByIds', e);
  //     rethrow;
  //   } catch (e, s) {
  //     throw GeneralFailure(
  //       type: GeneralFailureType.unexpectedError,
  //       description: 'RepoService - _fetchProjectsByIds ${e.toString()}',
  //       stackTrace: s,
  //     );
  //   }
  // }

  Future<void> addNewEnvironment(String name, String color, String icon) async {
    try {
      final env = await _functions.createEnvironment(EnvironmentModel(
        id: '',
        admins: [],
        name: name,
        color: color,
        icon: icon,
      ));

      _environments[env.id] = env;
      notifyListeners();
    } on FunctionsFailure catch (e) {
      _log.e('RepoService - addNewEnvironment', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - addNewEnvironment ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  Future<void> addNewProject(
      String name, String color, String environmentId) async {
    try {
      final project = await _functions.createProject(ProjectModel(
        id: '',
        name: name,
        color: color,
        parentEnvironmentId: environmentId,
        members: [],
      ));
      _projects[project.id] = project;
      notifyListeners();
    } on FunctionsFailure catch (e) {
      _log.e('RepoService - addNewProject', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - addNewProject ${e.toString()}',
        stackTrace: s,
      );
    }
  }
}
