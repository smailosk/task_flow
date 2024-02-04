import 'package:stacked/stacked.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/services/repo_service.dart';

class HomeViewModel extends BaseViewModel with IndexTrackingStateHelper {
  final _log = getLogger('HomeViewModel');
  final _repo = locator<RepoService>();
  init() {
    _repo.init();
  }
}
