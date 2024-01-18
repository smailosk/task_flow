import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'environment_viewmodel.dart';

class EnvironmentView extends StatelessWidget {
  const EnvironmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EnvData> categories = [
      EnvData('Home', Colors.yellow, Icons.home_outlined),
      EnvData('Work', Colors.pink, Icons.work_outline),
      EnvData('Home', Colors.greenAccent, Icons.privacy_tip_outlined),
    ];

    return ViewModelBuilder<EnvironmentViewModel>.reactive(
      viewModelBuilder: () => EnvironmentViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: const Column(
              children: [
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EnvData {
  final String title;
  final Color color;
  final IconData icon;

  EnvData(this.title, this.color, this.icon);
}
