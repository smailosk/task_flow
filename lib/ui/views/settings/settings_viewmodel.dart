import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.router.dart';
import 'package:task_flow/services/auth_service.dart';

class SettingsViewModel extends BaseViewModel {
  final _auth = locator<AuthService>();
  final _navigation = locator<NavigationService>();

  signOut() async {
    await _auth.signOut();
    _navigation.clearStackAndShow(Routes.startupView);
  }

  navigateToEditProfile() {
    _navigation.navigateTo(Routes.editProfileView);
  }
}
