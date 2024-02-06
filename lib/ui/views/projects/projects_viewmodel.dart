import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.router.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';

class ProjectsViewModel extends ReactiveViewModel {
  ProjectsViewModel(this.environmentId);

  @override
  List<ListenableServiceMixin> get listenableServices => [_repoService];
  final String environmentId;

  final _navigationService = locator<NavigationService>();
  final _repoService = locator<RepoService>();

  List<ProjectModel> get projects => _repoService.projects.values
      .where((element) => element.parentEnvironmentId == environmentId)
      .toList();

  List<TaskModel> getTasksForProject(String projectId) {
    return _repoService.tasksByProject[projectId]?.values.toList() ?? [];
  }

  init() async {
    setBusy(true);
    // await _repoService.fetchTasksForProject(projects.first.id);
    await Future.wait(projects
        .map((element) => _repoService.fetchTasksForProject(element.id)));

    setBusy(false);
  }

  navigateToAddProject() {
    _navigationService.navigateToAddProjectView(environmentId: environmentId);
  }

  navigateToTasksView(int index) {
    _navigationService.navigateTo(
      Routes.tasksView,
      arguments: TasksViewArguments(projectId: projects[index].id),
    );
  }

  back() {
    _navigationService.back();
  }
}
