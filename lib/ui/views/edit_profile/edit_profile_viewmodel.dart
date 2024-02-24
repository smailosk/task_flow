import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/ui/views/edit_profile/edit_profile_view.form.dart';

class EditProfileViewModel extends FormViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _log = getLogger('EditProfileViewModel');

  init() async {
    setBusy(true);
    final user = await _authService.currentUser;

    if (user != null) {
      emailValue = user.email;
      userNameValue = user.displayName;
      initialUserName = userNameValue ?? '';
      passwordValue = '*********';
    }
    setBusy(false);
  }

  String initialUserName = '';
  bool _isEditingPassword = false;
  bool get isEditingPassword => _isEditingPassword;

  bool get userNameUpdated => userNameValue != initialUserName;

  _setIsEditingPassword(bool value) {
    if (value == true) {
      passwordValue = '';
    } else {
      passwordValue = '*********';
    }
    _isEditingPassword = value;
    notifyListeners();
  }

  editPassword() {
    _log.i('');
    if (!_isEditingPassword) {
      _setIsEditingPassword(true);
    }
  }

  savePassword() {
    setBusyForObject('password', true);
    _log.i(passwordValue);
    if (passwordValue == null) {
      _log.i('passwordValue is null');

      return;
    }
    // validateForm();
    // if (hasAnyValidationMessage) return;
    _authService.updatePassword(passwordValue!).executeFuture((onError) {
      _log.e(onError);
      setBusyForObject('password', false);

      _setIsEditingPassword(false);
    }, (onSuccess) {
      _log.i('Password updated');
      setBusyForObject('password', false);

      _setIsEditingPassword(false);
    });
  }

  changeUsername() {
    _authService.updateUsername(userNameValue!).executeFuture((onError) {
      _log.e(onError);
    }, (onSuccess) {
      initialUserName = userNameValue!;
      notifyListeners();
      _log.i('Username updated');
    });
  }

  back() {
    _navigationService.back();
  }
}
