import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:task_flow/ui/common/app_colors.dart';
import 'package:task_flow/ui/common/form_validators.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/keyboard_dismiss_floating_button.dart';

import 'login_view.form.dart';
import 'login_viewmodel.dart';

@FormView(autoTextFieldValidation: false, fields: [
  FormTextField(name: 'email', validator: FormValidators.validateEmail),
  FormTextField(name: 'password', validator: FormValidators.validatePassword)
])
class LoginView extends StatelessWidget with $LoginView {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onDispose: (viewModel) => disposeForm(),
      onViewModelReady: (viewModel) {
        syncFormWithViewModel(viewModel);
      },
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: const KeyboardDismissFloatingButton(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'TASK-FLOW',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Color(0xFF24A19C),
                  ),
                ),
                Text(
                  'Login to your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                verticalSpaceMedium,
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: 'Email',
                    errorText: viewModel.emailValidationMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: 'Password',
                    errorText: viewModel.passwordValidationMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?',
                        style: TextStyle(color: Colors.blueGrey)),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: viewModel.signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: viewModel.isBusy
                      ? const CircularProgressIndicator()
                      : const Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                          )),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.grey,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or Login with'),
                    ),
                    Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.grey,
                    )),
                  ],
                ),
                const SizedBox(height: 30),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     SignInButton(
                //       Buttons.Facebook,
                //       onPressed: () {},
                //     ),
                //     SignInButton(
                //       Buttons.Google,
                //       onPressed: () {},
                //     ),
                //     SignInButton(
                //       Buttons.Twitter,
                //       onPressed: () {},
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.navigateToSignUp();
                      },
                      child: const Text('Register Now',
                          style: TextStyle(
                              color: kcPrimaryColor,
                              fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
