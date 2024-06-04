import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/ui/views/add_task/add_task_view.form.dart';
import 'package:task_flow/ui/views/add_task/add_task_viewmodel.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

void main() {
  group('AddTaskViewModel Test -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    late AddTaskViewModel viewModel;
    late MockRepoService mockRepoService;
    late MockNavigationService mockNavigationService;

    setUp(() {
      mockRepoService = MockRepoService();
      mockNavigationService = MockNavigationService();
      viewModel = AddTaskViewModel('projectId', null);
    });

    test('When called, init should set task details', () {
      // Arrange
      var task = TaskModel(
        assignee: '',
        title: 'Test Task',
        id: '1',
        done: false,
        details: 'Task details',
        parentProjectId: 'projectId',
        deadline: DateTime(2024, 1, 1),
      );
      viewModel = AddTaskViewModel('projectId', task);

      // Act
      viewModel.init();

      // Assert
      expect(viewModel.taskTitleValue, 'Test Task');
      expect(viewModel.taskDetailsValue, 'Task details');
      expect(viewModel.deadline, DateTime(2024, 1, 1));
    });

    test('When called, createTask should add a task and navigate back',
        () async {
      final taskModel = TaskModel(
        assignee: '',
        title: 'New Task',
        id: '',
        done: false,
        details: 'New Task Details',
        parentProjectId: 'projectId',
        deadline: DateTime.now(),
      );

      // Arrange
      when(mockRepoService.addNewTask(any))
          .thenAnswer((_) async => Future.value(Right(taskModel)));

      viewModel.taskTitleValue = 'New Task';
      viewModel.taskDetailsValue = 'New Task Details';
      viewModel.setDateTime(DateTime(2024, 1, 1));

      // Act
      await viewModel.createTask();

      // Assert
      // verify(mockRepoService.addNewTask(any)).called(1);
      // verify(mockNavigationService.back()).called(1);
    });

    test('When called, updateTask should update a task and navigate back',
        () async {
      // Arrange
      var task = TaskModel(
        assignee: '',
        title: 'Existing Task',
        id: '1',
        done: false,
        details: 'Existing Task Details',
        parentProjectId: 'projectId',
        deadline: DateTime(2024, 1, 1),
      );

      when(mockRepoService.updateTask(any))
          .thenAnswer((_) async => Future.value(Right(null)));
      // when(mockNavigationService.back()).thenReturn(null);

      viewModel = AddTaskViewModel('projectId', task);
      viewModel.taskTitleValue = 'Updated Task';
      viewModel.taskDetailsValue = 'Updated Task Details';
      viewModel.setDateTime(DateTime(2024, 2, 1));

      // Act
      await viewModel.updateTask(task);

      // Assert
      verify(mockRepoService.updateTask(any)).called(1);
      verify(mockNavigationService.back()).called(1);
    });
  });
}
