import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/app/app.router.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/ui/views/login/login_view.form.dart';

class LoginViewModel extends FormViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _log = getLogger('LoginViewModel');

  // createAccount() {
  //   if (emailValue == null || passwordValue == null) return;

  //   validateForm();
  //   if (hasAnyValidationMessage) return;

  //   setBusy(true);

  //   Executor.run(
  //           _authService.createAccountWithEmail(emailValue!, passwordValue!,us))
  //       .then((value) => value.fold((l) {
  //             setBusy(false);
  //           }, (r) {
  //             _navigationService.clearStackAndShow(Routes.homeView);
  //           }));
  // }

  signIn() {
    validateForm();

    if (emailValue == null || passwordValue == null) return;

    if (hasAnyValidationMessage) return;

    setBusy(true);
    _log.i(emailValue);
    _log.i(passwordValue);

    Executor.run(_authService.signInWithEmailAndPassowrd(
            emailValue!, passwordValue!))
        .then((value) => value.fold((l) {
              setBusy(false);
            }, (r) {
              _navigationService.clearStackAndShow(Routes.homeView);
            }));
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(Routes.signUpView);
  }
}
