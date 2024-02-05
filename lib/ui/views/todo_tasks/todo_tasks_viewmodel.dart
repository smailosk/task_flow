import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class TodoTasksViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  List<TaskModel> tasks = [
    TaskModel(id: '1', title: 'Task 1', isCompleted: false),
    TaskModel(id: '2', title: 'Task 2', isCompleted: true),
    TaskModel(id: '3', title: 'Task 3', isCompleted: false),
    TaskModel(id: '4', title: 'Task 4', isCompleted: true),
  ];

  void toggleTaskCompletion(String taskId) {
    final task = tasks.firstWhere((task) => task.id == taskId);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  back() {
    _navigationService.back();
  }
}

class TaskModel {
  final String id;
  final String title;
  bool isCompleted;

  TaskModel({required this.id, required this.title, this.isCompleted = false});
}
