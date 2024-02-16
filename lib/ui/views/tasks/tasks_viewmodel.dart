import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/app/app.router.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';

import '../../../app/app.locator.dart';

class TasksViewModel extends ReactiveViewModel {
  @override
  List<ListenableServiceMixin> get listenableServices => [_repoService];
  final _navigationService = locator<NavigationService>();
  final _repoService = locator<RepoService>();
  final _log = getLogger('TasksViewModel');
  final String projectId;
  TasksViewModel(this.projectId);

  List<TaskModel> get tasks =>
      _repoService.tasksByProject[projectId]?.values.toList() ?? [];

  init() {
    setBusy(true);
    setBusy(false);
  }

  void toggleTaskCompletion(int index, bool doneValue) {
    final task = tasks[index];

    Executor.run(_repoService.setTaskAsDone(task, doneValue))
        .then((value) => value.fold((failure) {}, (r) {
              _log.i('Marked as :${!task.done}');
            }));
  }

  navigateToAddTask() {
    _navigationService.navigateToAddTaskView(projectId: projectId);
  }

  back() {
    _navigationService.back();
  }

  void deleteTask(int index) {
    _log.i('Deleting task ${tasks[index].title}');

    Executor.run(_repoService.deleteTask(tasks[index]))
        .then((value) => value.fold((l) {}, (r) {
              _log.i('Task deleted');
            }));
  }

  void editTask(int index) {
    _navigationService.navigateTo(
      Routes.addTaskView,
      arguments: AddTaskViewArguments(projectId: projectId, task: tasks[index]),
    );
  }
}
