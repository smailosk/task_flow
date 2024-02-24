import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/ui_helpers.dart';
import '../../common/widgets/main_button.dart';
import 'edit_profile_view.form.dart';
import 'edit_profile_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'userName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class EditProfileView extends StackedView<EditProfileViewModel>
    with $EditProfileView {
  const EditProfileView({super.key});

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool obscureText = false,
    Widget? suffixIcon,
    bool readOnly = false,
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
          focusNode: focusNode,
          readOnly: readOnly,
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
              focusNode: userNameFocusNode,
              controller: userNameController,
              label: 'Username',
            ),
            _buildTextField(
                focusNode: emailFocusNode,
                controller: emailController,
                label: 'Email',
                readOnly: true),
            _buildTextField(
              focusNode: passwordFocusNode,
              controller: passwordController,
              label: 'Password',
              readOnly: !viewModel.isEditingPassword,
              suffixIcon: !viewModel.busy('password')
                  ? TextButton(
                      onPressed: () {
                        if (viewModel.isEditingPassword) {
                          viewModel.savePassword();
                        } else {
                          viewModel.editPassword();
                          passwordFocusNode.requestFocus();
                        }
                      },
                      child: viewModel.isEditingPassword
                          ? const Text('Save New Password')
                          : const Text('Change Password'),
                    )
                  : const CircularProgressIndicator(),
            ),
            verticalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainButton(
                  enabled: true,
                  onPressed: viewModel.back,
                  text: 'Cancel',
                ),
                MainButton(
                  enabled: viewModel.userNameUpdated,
                  text: 'Save Changes',
                  color: const Color(0xFF24A19C),
                  onPressed: viewModel.changeUsername,
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

  @override
  void onViewModelReady(EditProfileViewModel viewModel) {
    syncFormWithViewModel(viewModel);

    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(EditProfileViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
