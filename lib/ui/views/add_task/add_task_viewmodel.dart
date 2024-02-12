import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/ui/views/add_task/add_task_view.form.dart';

class AddTaskViewModel extends FormViewModel {
  final String projectId;
  final _repoService = locator<RepoService>();
  final _navigationService = locator<NavigationService>();

  AddTaskViewModel(this.projectId);

  createTask() {
    Executor.run(_repoService.addNewTask(TaskModel(
            assignee: '',
            title: taskTitleValue ?? '',
            id: '',
            done: false,
            details: taskDetailsValue ?? '',
            parentProjectId: projectId,
            deadline: DateTime.now())))
        .then((value) => value.fold((l) {}, (r) {
              _navigationService.back();
            }));
  }

  back() {
    _navigationService.back();
  }
}