import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/ui_helpers.dart';
import '../../common/widgets/main_button.dart';
import 'edit_profile_view.form.dart';
import 'edit_profile_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'userName'),
  FormTextField(name: 'fullName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class EditProfileView extends StackedView<EditProfileViewModel>
    with $EditProfileView {
  const EditProfileView({super.key});

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
        verticalSpace(5),
        TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: suffixIcon,
          ),
          controller: controller,
          obscureText: obscureText,
        ),
        verticalSpace(20),
      ],
    );
  }

  @override
  Widget builder(
      BuildContext context, EditProfileViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              // Replace with your image provider
            ),
            verticalSpace(30),
            _buildTextField(
              controller: userNameController,
              label: 'Username',
              initialValue: 'Username',
              // controller: labelController,
            ),
            _buildTextField(
              controller: fullNameController,
              label: 'Full Name',
              initialValue: 'Full Name',
              // controller: fullNameController,
            ),
            _buildTextField(
              controller: emailController,
              label: 'Email',
              initialValue: 'Email',
              // controller: emailController,
            ),
            _buildTextField(
              controller: passwordController,
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
    );
  }

  @override
  EditProfileViewModel viewModelBuilder(BuildContext context) {
    return EditProfileViewModel();
  }
}
