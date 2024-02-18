import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/constants/colors.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/ui/views/add_project/add_project_view.form.dart';

class AddProjectViewModel extends FormViewModel {
  final _log = getLogger('AddProjectViewModel');
  final String environmentId;
  AddProjectViewModel(this.environmentId);
  final _navigationService = locator<NavigationService>();
  final _repo = locator<RepoService>();
  int _selectedColorIndex = 0;

  int get selectedColorIndex => _selectedColorIndex;
  List<String> get colors => kProjectColors;

  EnvironmentModel? get environment => _repo.environments[environmentId];

  void updateSelectedColor(int index) {
    projectColorValue = colors[index];
    _selectedColorIndex = index;
    notifyListeners();
  }

  init() {
    setInitialised(true);
    updateSelectedColor(0);
  }

  back() {
    _navigationService.back();
  }

  addProject() {
    setBusy(true);
    Executor.run(_repo.addNewProject(projectNameValue ?? 'No name provided',
            projectColorValue ?? '#000000', environmentId))
        .then((value) => value.fold((failure) {
              _log.e('Failed to add Project', failure);
              setBusy(false);
            }, (success) {
              setBusy(false);

              _log.i('Project added successfully');
              _navigationService.back();
            }));
  }
}
