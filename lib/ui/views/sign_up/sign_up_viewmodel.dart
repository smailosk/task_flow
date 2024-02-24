import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.router.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/ui/views/sign_up/sign_up_view.form.dart';
import 'package:task_flow/core/error_handling/executor.dart';

class SignUpViewModel extends FormViewModel {
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  void signUp() {
    if (emailValue == null || passwordValue == null || userNameValue == null) {
      return;
    }

    validateForm();

    if (hasAnyValidationMessage) return;

    setBusy(true);

    _authService
        .createAccountWithEmail(emailValue!, passwordValue!, userNameValue)
        .executeFuture((failure) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Error',
        description: failure.description,
      );
    }, (user) async {
      await Future.delayed(const Duration(seconds: 2));
      _navigationService.navigateToHomeView();
    });
  }
}
