import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/constants/colors.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/ui/views/add_project/add_project_view.form.dart';

class AddProjectViewModel extends FormViewModel {
  final _log = getLogger('AddProjectViewModel');
  final String environmentId;
  AddProjectViewModel(this.environmentId, this.project);
  final _navigationService = locator<NavigationService>();
  final _repo = locator<RepoService>();
  int _selectedColorIndex = 0;

  int get selectedColorIndex => _selectedColorIndex;
  List<String> get colors => kProjectColors;

  EnvironmentModel? get environment => _repo.environments[environmentId];

  final ProjectModel? project;

  void updateSelectedColor(int index) {
    projectColorValue = colors[index];
    _selectedColorIndex = index;
    notifyListeners();
  }

  init(AutoScrollController scrollController) {
    if (project != null) {
      projectNameValue = project!.name;
      projectColorValue = project!.color;
      updateSelectedColor(kProjectColors.indexOf(project!.color));
      scrollController.scrollToIndex(
        kProjectColors.indexOf(project!.color),
        preferPosition: AutoScrollPosition.middle,
      );
    } else {
      updateSelectedColor(0);
    }
    setInitialised(true);
  }

  back() {
    _navigationService.back();
  }

  addProject() {
    setBusy(true);
    Executor.runFuture(_repo.addNewProject(
            projectNameValue ?? 'No name provided',
            projectColorValue ?? '#000000',
            environmentId))
        .then((value) => value.fold((failure) {
              _log.e('Failed to add Project', failure);
              setBusy(false);
            }, (success) {
              setBusy(false);

              _log.i('Project added successfully');
              _navigationService.back();
            }));
  }

  updateProject() {
    setBusy(true);
    Executor.runFuture(_repo.editProject(project!.copyWith(
      color: projectColorValue!,
      name: projectNameValue!,
    ))).then((value) => value.fold((failure) {
          _log.e('Failed to update Project', failure);
          setBusy(false);
        }, (success) {
          setBusy(false);

          _log.i('Project updated successfully');
          _navigationService.back();
        }));
  }
}
