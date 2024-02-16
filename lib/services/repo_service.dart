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
  final Map<String, Map<String, TaskModel>> _tasksByProject = {};

  Map<String, EnvironmentModel> get environments => _environments;
  Map<String, ProjectModel> get projects => _projects;
  Map<String, Map<String, TaskModel>> get tasksByProject => _tasksByProject;

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
      _tasksByProject[projectId] = {for (var e in data) e.id: e};
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

  Future<void> setTaskAsDone(TaskModel task, bool doneValue) async {
    try {
      _tasksByProject[task.parentProjectId]?[task.id] =
          _tasksByProject[task.parentProjectId]![task.id]!
              .copyWith(done: doneValue);
      notifyListeners();
      await _functions.markTaskDone(TaskModel(
          title: '',
          id: task.id,
          done: doneValue,
          details: '',
          parentProjectId: task.parentProjectId,
          deadline: null,
          assignee: ''));
    } on Failure catch (e) {
      _log.e('RepoService - setTaskDone', e);
      _tasksByProject[task.parentProjectId]?[task.id] =
          _tasksByProject[task.parentProjectId]![task.id]!
              .copyWith(done: !doneValue);
      rethrow;
    } catch (e, s) {
      _tasksByProject[task.parentProjectId]?[task.id] =
          _tasksByProject[task.parentProjectId]![task.id]!
              .copyWith(done: !doneValue);
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - setTaskDone ${e.toString()}',
        stackTrace: s,
      );
    }

    await Future.delayed(const Duration(milliseconds: 300));
    notifyListeners();
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

  Future<void> addNewTask(TaskModel task) async {
    try {
      final newTask = await _functions.createTask(task);

      _tasksByProject[task.parentProjectId]![newTask.id] = newTask;
      notifyListeners();
    } on Failure catch (e) {
      _log.e('RepoService - addNewTask', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - addNewTask ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  Future updateTask(TaskModel taskModel) async {
    try {
      _tasksByProject[taskModel.parentProjectId]?[taskModel.id] = taskModel;
      notifyListeners();
      // return _functions.updateTask(taskModel);
    } on Failure catch (e) {
      _log.e('RepoService - updateTask', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - updateTask ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  Future deleteTask(TaskModel task) async {
    try {
      _tasksByProject[task.parentProjectId]?.remove(task.id);
      notifyListeners();
      // return _functions.deleteTask(task);
    } on Failure catch (e) {
      _log.e('RepoService - deleteTask', e);
      rethrow;
    } catch (e, s) {
      throw GeneralFailure(
        type: GeneralFailureType.unexpectedError,
        description: 'RepoService - deleteTask ${e.toString()}',
        stackTrace: s,
      );
    }
  }

  ProjectModel getProjectById(String projectId) {
    return _projects[projectId]!;
  }
}
