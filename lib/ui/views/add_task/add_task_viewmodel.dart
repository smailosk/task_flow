import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/ui/views/add_task/add_task_view.form.dart';

class AddTaskViewModel extends FormViewModel {
  final String projectId;
  final TaskModel? task;
  final _repoService = locator<RepoService>();
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  AddTaskViewModel(this.projectId, this.task);
  final _log = getLogger('AddTaskViewModel');
  ProjectModel? get project => _repoService.getProjectById(projectId);

  void init() {
    if (task != null) {
      taskTitleValue = task!.title;
      taskDetailsValue = task!.details;
      _deadline = task!.deadline ?? DateTime.now();
      notifyListeners();
    }
  }

  DateTime _deadline = DateTime.now();
  DateTime get deadline => _deadline;

  setDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      _deadline = dateTime;
      notifyListeners();
    }
  }

  createTask() {
    Executor.run(_repoService.addNewTask(TaskModel(
            assignee: '',
            title: taskTitleValue ?? '',
            id: '',
            done: false,
            details: taskDetailsValue ?? '',
            parentProjectId: projectId,
            deadline: _deadline)))
        .then((value) => value.fold((l) {}, (r) {
              _log.i('Task created');
              _navigationService.back();
            }));
  }

  updateTask(TaskModel task) {
    Executor.run(_repoService.updateTask(task.copyWith(
            title: taskTitleValue ?? '',
            details: taskDetailsValue ?? '',
            deadline: _deadline)))
        .then((value) => value.fold((l) {}, (r) {
              _navigationService.back();
            }));
  }

  back() {
    _navigationService.back();
  }
}
