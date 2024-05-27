import 'package:task_flow/core/models/task/task.dart';

// Mock tasks
final List<TaskModel> mockTasks = [
  TaskModel(
    id: 'task-1',
    title: 'Mock Task 1',
    details: 'Mock Task Details 1',
    deadline: DateTime(2024, 1, 1),
    done: false,
    parentProjectId: 'project-1',
    assignee: '',
  ),
  TaskModel(
    id: 'task-2',
    title: 'Mock Task 2',
    details: 'Mock Task Details 2',
    deadline: DateTime(2024, 2, 1),
    done: false,
    parentProjectId: 'project-1',
    assignee: '',
  ),
];
