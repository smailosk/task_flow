import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';

class ProjectsViewModel extends BaseViewModel {
  ProjectsViewModel(this.environmentId);

  final String environmentId;

  final _navigationService = locator<NavigationService>();
  final _repoService = locator<RepoService>();

  List<Project> get projects => _repoService.projects.values
      .where((element) => element.parentEnvironmentId == environmentId)
      .toList();

  List<ToDoTask> getTasksForProject(String projectId) {
    return _repoService.tasksByProject[projectId] ?? [];
  }

  init() async {
    setBusy(true);
    // await _repoService.fetchTasksForProject(projects.first.id);
    await Future.wait(projects
        .map((element) => _repoService.fetchTasksForProject(element.id)));

    setBusy(false);
  }

  back() {
    _navigationService.back();
  }
}
