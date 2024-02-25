import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/app/app.router.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/services/repo_service.dart';

class EnvironmentViewModel extends ReactiveViewModel {
  final _log = getLogger('EnvironmentViewModel');

  final _navigationService = locator<NavigationService>();
  final _repo = locator<RepoService>();
  final _auth = locator<AuthService>();
  String get displayName => _auth.displayName ?? '';

  @override
  List<ListenableServiceMixin> get listenableServices => [_repo];

  List<EnvironmentModel> get environments => _repo.environments.values.toList();
  init() {
    // _environments.clear();
    // _environments.addAll(_repo.environments.values.toList());
    // _log.i(
    //     'EnvironmentViewModel - init - _environments: ${_environments.length}');
  }

  navigatoToAddEnvironment() {
    _log.i('navigatoToAddEnvironment');
    _navigationService.navigateToAddEnvironmentView(environmentModel: null);
  }

  openEnvironment(int index) {
    _log.i('openEnvironment - $index');
    _navigationService.navigateToProjectsView(
        environmentId: environments[index].id);
    // _navigationService.navigateTo(Routes.environmentView,
    //     arguments: EnvironmentViewArguments(environment: environments[index]));
  }

  void navigateToEditEnvironment(int index) {
    _log.i('navigateToEditEnvironment $index');
    _navigationService.navigateToAddEnvironmentView(
        environmentModel: environments[index]);
  }

  void deleteEnvironment(int index) {
    _log.i('deleteEnvironment $index');
    _repo.deleteEnvironment(environments[index].id);
  }
}
