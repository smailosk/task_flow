import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tilePadding = 20.0;
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              verticalSpaceMedium,
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ismail Amor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Text('@ismail_amor'),
              const SizedBox(height: 20),
              _buildSettingsTile(
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Personal Information'),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit profile
                  },
                ),
              ),
              _buildSettingsTile(
                const ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              _buildSettingsTile(
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              _buildSettingsTile(
                const ListTile(
                  leading: Icon(Icons.privacy_tip),
                  title: Text('Privacy'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              _buildSettingsTile(
                const ListTile(
                  leading: Icon(Icons.group_add),
                  title: Text('Invite a friend'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth - (tilePadding * 2),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: viewModel.signOut,
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF7E987),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSettingsTile(Widget child) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: child,
  );
}
