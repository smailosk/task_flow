import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/views/sign_up/sign_up_view.form.dart';

import 'sign_up_viewmodel.dart';

@FormView(autoTextFieldValidation: false, fields: [
  FormTextField(name: 'userName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
  FormTextField(name: 'confirmPassword'),
])
class SignUpView extends StatelessWidget with $SignUpView {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                  'Hello! Register to get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.normal),
                ),
                verticalSpaceMedium,
                TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    labelText: 'Username',
                    // errorText: viewModel.emailValidationMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                verticalSpace(20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: 'Email',
                    // errorText: viewModel.emailValidationMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                verticalSpace(20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: 'Password',
                    // errorText: viewModel.passwordValidationMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                verticalSpace(20),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: 'Confirm Password',
                    // errorText: viewModel.passwordValidationMessage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                verticalSpaceLarge,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF24A19C),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                verticalSpaceMedium,
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.grey,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or Register with'),
                    ),
                    Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.grey,
                    )),
                  ],
                ),
                verticalSpaceMedium,
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
                TextButton(
                  onPressed: () {},
                  child: const Text('Add FB, twitter and Google',
                      style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
