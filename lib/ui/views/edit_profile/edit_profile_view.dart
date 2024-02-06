import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import '../../common/widgets/main_button.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      // onViewModelReady: (viewModel) {
      //   syncFormWithViewModel(viewModel);
      // },
      // onDispose: (viewModel) {
      //   disposeForm();
      // },
      builder: (context, viewModel, child) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
                // Replace with your image provider
              ),
              verticalSpaceLarge,
              _buildTextField(
                label: 'Username',
                initialValue: 'Username',
                // controller: labelController,
              ),
              _buildTextField(
                label: 'Full Name',
                initialValue: 'Full Name',
                // controller: fullNameController,
              ),
              _buildTextField(
                label: 'Email',
                initialValue: 'Email',
                // controller: emailController,
              ),
              _buildTextField(
                label: 'Password',
                initialValue: '********',
                // controller: passwordController,
                obscureText: true,
                suffixIcon: TextButton(
                  child: const Text('Change Password'),
                  onPressed: () {
                    // Handle password change
                  },
                ),
              ),
              verticalSpaceLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(
                    enabled: true,
                    onPressed: () {},
                    text: 'Cancel',
                  ),
                  MainButton(
                    enabled: true,
                    text: 'Save Changes',
                    color: const Color(0xFF24A19C),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    required String initialValue,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceSmall,
        TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: suffixIcon,
          ),
          controller: controller,
          obscureText: obscureText,
        ),
        verticalSpaceMedium
      ],
    );
  }
}
