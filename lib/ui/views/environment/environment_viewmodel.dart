import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/services/firestore_service.dart';

class EnvironmentViewModel extends BaseViewModel {
  final _firestore = locator<FirestoreService>();
  final _log = getLogger('EnvironmentViewModel');
  List<EnvData> environments = [
    EnvData('Home', Colors.yellow, Icons.home_outlined),
    EnvData('Private', Colors.greenAccent, Icons.privacy_tip_outlined),
    EnvData('Work 1', Colors.pink, Icons.work_outline),
    EnvData('Work 2', Colors.pinkAccent.shade100, Icons.work_outline),
    EnvData('Home 2', Colors.yellow.shade800, Icons.home_outlined),
  ];
  String newEnvironmentTitle = '';

  void addNewEnvironment() {
    var newEnv = EnvData(
      newEnvironmentTitle,
      Colors.blue,
      Icons.task,
    );
    environments.add(newEnv);
    notifyListeners();
  }

  init() async {
    final envs = await _firestore.fetchEnvironments();

    _log.i(envs);
  }
}

class EnvData {
  final String title;
  final Color color;
  final IconData icon;

  EnvData(this.title, this.color, this.icon);
}
