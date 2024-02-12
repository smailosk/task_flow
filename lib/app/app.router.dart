// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i14;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i15;
import 'package:task_flow/ui/views/add_environment/add_environment_view.dart'
    as _i6;
import 'package:task_flow/ui/views/add_project/add_project_view.dart' as _i10;
import 'package:task_flow/ui/views/add_task/add_task_view.dart' as _i12;
import 'package:task_flow/ui/views/calendar/calendar_view.dart' as _i8;
import 'package:task_flow/ui/views/edit_profile/edit_profile_view.dart' as _i13;
import 'package:task_flow/ui/views/environment/environment_view.dart' as _i5;
import 'package:task_flow/ui/views/home/home_view.dart' as _i2;
import 'package:task_flow/ui/views/login/login_view.dart' as _i4;
import 'package:task_flow/ui/views/projects/projects_view.dart' as _i9;
import 'package:task_flow/ui/views/settings/settings_view.dart' as _i7;
import 'package:task_flow/ui/views/startup/startup_view.dart' as _i3;
import 'package:task_flow/ui/views/tasks/tasks_view.dart' as _i11;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/';

  static const loginView = '/login-view';

  static const environmentView = '/environment-view';

  static const addEnvironmentView = '/add-environment-view';

  static const settingsView = '/settings-view';

  static const calendarView = '/calendar-view';

  static const projectsView = '/projects-view';

  static const addProjectView = '/add-project-view';

  static const tasksView = '/tasks-view';

  static const addTaskView = '/add-task-view';

  static const editProfileView = '/edit-profile-view';

  static const all = <String>{
    homeView,
    startupView,
    loginView,
    environmentView,
    addEnvironmentView,
    settingsView,
    calendarView,
    projectsView,
    addProjectView,
    tasksView,
    addTaskView,
    editProfileView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i4.LoginView,
    ),
    _i1.RouteDef(
      Routes.environmentView,
      page: _i5.EnvironmentView,
    ),
    _i1.RouteDef(
      Routes.addEnvironmentView,
      page: _i6.AddEnvironmentView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i7.SettingsView,
    ),
    _i1.RouteDef(
      Routes.calendarView,
      page: _i8.CalendarView,
    ),
    _i1.RouteDef(
      Routes.projectsView,
      page: _i9.ProjectsView,
    ),
    _i1.RouteDef(
      Routes.addProjectView,
      page: _i10.AddProjectView,
    ),
    _i1.RouteDef(
      Routes.tasksView,
      page: _i11.TasksView,
    ),
    _i1.RouteDef(
      Routes.addTaskView,
      page: _i12.AddTaskView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i13.EditProfileView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginView(),
        settings: data,
      );
    },
    _i5.EnvironmentView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.EnvironmentView(),
        settings: data,
      );
    },
    _i6.AddEnvironmentView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.AddEnvironmentView(),
        settings: data,
      );
    },
    _i7.SettingsView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.SettingsView(),
        settings: data,
      );
    },
    _i8.CalendarView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.CalendarView(),
        settings: data,
      );
    },
    _i9.ProjectsView: (data) {
      final args = data.getArgs<ProjectsViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.ProjectsView(key: args.key, environmentId: args.environmentId),
        settings: data,
      );
    },
    _i10.AddProjectView: (data) {
      final args = data.getArgs<AddProjectViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.AddProjectView(
            key: args.key, environmentId: args.environmentId),
        settings: data,
      );
    },
    _i11.TasksView: (data) {
      final args = data.getArgs<TasksViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.TasksView(key: args.key, projectId: args.projectId),
        settings: data,
      );
    },
    _i12.AddTaskView: (data) {
      final args = data.getArgs<AddTaskViewArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i12.AddTaskView(key: args.key, projectId: args.projectId),
        settings: data,
      );
    },
    _i13.EditProfileView: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.EditProfileView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ProjectsViewArguments {
  const ProjectsViewArguments({
    this.key,
    required this.environmentId,
  });

  final _i14.Key? key;

  final String environmentId;

  @override
  String toString() {
    return '{"key": "$key", "environmentId": "$environmentId"}';
  }

  @override
  bool operator ==(covariant ProjectsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.environmentId == environmentId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ environmentId.hashCode;
  }
}

class AddProjectViewArguments {
  const AddProjectViewArguments({
    this.key,
    required this.environmentId,
  });

  final _i14.Key? key;

  final String environmentId;

  @override
  String toString() {
    return '{"key": "$key", "environmentId": "$environmentId"}';
  }

  @override
  bool operator ==(covariant AddProjectViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.environmentId == environmentId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ environmentId.hashCode;
  }
}

class TasksViewArguments {
  const TasksViewArguments({
    this.key,
    required this.projectId,
  });

  final _i14.Key? key;

  final String projectId;

  @override
  String toString() {
    return '{"key": "$key", "projectId": "$projectId"}';
  }

  @override
  bool operator ==(covariant TasksViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.projectId == projectId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ projectId.hashCode;
  }
}

class AddTaskViewArguments {
  const AddTaskViewArguments({
    this.key,
    required this.projectId,
  });

  final _i14.Key? key;

  final String projectId;

  @override
  String toString() {
    return '{"key": "$key", "projectId": "$projectId"}';
  }

  @override
  bool operator ==(covariant AddTaskViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.projectId == projectId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ projectId.hashCode;
  }
}

extension NavigatorStateExtension on _i15.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEnvironmentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.environmentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddEnvironmentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addEnvironmentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCalendarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.calendarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProjectsView({
    _i14.Key? key,
    required String environmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.projectsView,
        arguments:
            ProjectsViewArguments(key: key, environmentId: environmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddProjectView({
    _i14.Key? key,
    required String environmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addProjectView,
        arguments:
            AddProjectViewArguments(key: key, environmentId: environmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTasksView({
    _i14.Key? key,
    required String projectId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tasksView,
        arguments: TasksViewArguments(key: key, projectId: projectId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddTaskView({
    _i14.Key? key,
    required String projectId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addTaskView,
        arguments: AddTaskViewArguments(key: key, projectId: projectId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEnvironmentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.environmentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddEnvironmentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addEnvironmentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCalendarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.calendarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProjectsView({
    _i14.Key? key,
    required String environmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.projectsView,
        arguments:
            ProjectsViewArguments(key: key, environmentId: environmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddProjectView({
    _i14.Key? key,
    required String environmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addProjectView,
        arguments:
            AddProjectViewArguments(key: key, environmentId: environmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTasksView({
    _i14.Key? key,
    required String projectId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tasksView,
        arguments: TasksViewArguments(key: key, projectId: projectId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddTaskView({
    _i14.Key? key,
    required String projectId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addTaskView,
        arguments: AddTaskViewArguments(key: key, projectId: projectId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
