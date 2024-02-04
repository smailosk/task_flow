import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/ui/views/add_environment/add_environment_view.form.dart';

class AddEnvironmentViewModel extends FormViewModel {
  final _repo = locator<RepoService>();
  final _log = getLogger('AddEnvironmentViewModel');
  final _navigationService = locator<NavigationService>();
  int _selectedColorIndex = 0;
  int get selectedColorIndex => _selectedColorIndex;

  final _colors = <String>[];
  List<String> get colors => _colors;

  void updateSelectedColor(int index) {
    environmentColorValue = _colors[index];
    _selectedColorIndex = index;
    notifyListeners();
  }

  init() {
    _colors.addAll(Utils.generateRandomColors(20)
        .map((e) => Utils.colorToHex(e))
        .toList());
    setInitialised(true);
    updateSelectedColor(0);
  }

  addEnvironment() {
    // Add environment to the database

    // _log.i(environmentColorValue);
    // _log.i(environmentNameValue);
    // _log.i(environmentIconValue);
    Executor.run(_repo.addNewEnvironment(
            environmentNameValue ?? 'No name provided',
            environmentColorValue ?? '#000000',
            'environmentIconValue'))
        .then((value) => value.fold((failure) {
              _log.e('Failed to add environment', failure);
            }, (success) {
              _log.i('Environment added successfully');
              _navigationService.back();
            }));
  }

  back() {
    _navigationService.back();
  }
}
