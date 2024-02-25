import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/constants/colors.dart';
import 'package:task_flow/core/constants/icons.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/ui/views/add_environment/add_environment_view.form.dart';

class AddEnvironmentViewModel extends FormViewModel {
  final _repo = locator<RepoService>();
  final _log = getLogger('AddEnvironmentViewModel');
  final _navigationService = locator<NavigationService>();
  int _selectedColorIndex = 0;

  int get selectedColorIndex => _selectedColorIndex;

  List<String> get colors => kEnvironmentColors;

  List<int> get icons => iconsList;

  int _selectedIcon = iconsList[0];

  int get selectedIcon => _selectedIcon;

  AddEnvironmentViewModel({this.environmentModel});

  final EnvironmentModel? environmentModel;

  init() {
    if (environmentModel != null) {
      environmentNameValue = environmentModel!.name;
      updateSelectedColor(colors.indexOf(environmentModel!.color));
      setIcon(environmentModel!.icon);
    } else {
      updateSelectedColor(0);
      setIcon(0);
    }

    setInitialised(true);
  }

  void setIcon(int index) {
    _selectedIcon = iconsList[index];
    notifyListeners();
  }

  void updateSelectedColor(int index) {
    environmentColorValue = colors[index];
    _selectedColorIndex = index;
    notifyListeners();
  }

  addEnvironment() {
    setBusy(true);
    Executor.runFuture(_repo.addNewEnvironment(
            environmentNameValue ?? 'No name provided',
            environmentColorValue ?? '#000000',
            selectedIcon ?? 0))
        .then((value) => value.fold((failure) {
              _log.e('Failed to add environment', failure);
              setBusy(false);
            }, (success) {
              setBusy(false);

              _log.i('Environment added successfully');
              _navigationService.back();
            }));
  }

  back() {
    _navigationService.back();
  }
}
