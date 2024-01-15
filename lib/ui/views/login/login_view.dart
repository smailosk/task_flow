import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
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
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Color(0xFF24A19C),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Login to your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: 'Password',
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
                  onPressed: () {
                    // Login event
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF24A19C),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Login',
                      style: TextStyle(color: Colors.white)),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SignInButton(
                      Buttons.Facebook,
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.Twitter,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {},
                  child: const Text('Don’t have an account? Register Now',
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
