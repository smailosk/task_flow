import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/app/app.router.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/services/repo_service.dart';

class EnvironmentViewModel extends ReactiveViewModel {
  final _log = getLogger('EnvironmentViewModel');

  final _navigationService = locator<NavigationService>();
  final _repo = locator<RepoService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_repo];

  final List<Environment> _environments = [];
  List<Environment> get environments => _repo.environments.values.toList();
  init() {
    // _environments.clear();
    // _environments.addAll(_repo.environments.values.toList());
    // _log.i(
    //     'EnvironmentViewModel - init - _environments: ${_environments.length}');
  }

  navigatoToAddEnvironment() {
    _log.i('navigatoToAddEnvironment');
    _navigationService.navigateTo(Routes.addEnvironmentView);
  }
}
