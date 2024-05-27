import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/ui/views/add_task/add_task_viewmodel.dart';

class MockRepoService extends Mock implements RepoService {}

class MockNavigationService extends Mock implements NavigationService {}

void main() {
  // group('AddTaskViewModelTest -', () {
  //   AddTaskViewModel viewModel;
  //   MockRepoService mockRepoService;
  //   MockNavigationService mockNavigationService;
  //
  //   setUp(() {
  //     setupLocator();  // Ensure you have this function to setup your locator
  //     mockRepoService = MockRepoService();
  //     mockNavigationService = MockNavigationService();
  //     GetIt.instance
  //       ..registerLazySingleton<RepoService>(() => mockRepoService)
  //       ..registerLazySingleton<NavigationService>(() => mockNavigationService);
  //     viewModel = AddTaskViewModel('project-id', null);
  //   });
  //
  //   tearDown(() {
  //     GetIt.instance.reset();
  //   });
  //
  //   group('createTask -', () {
  //     test('When createTask is called, should interact with RepoService', () async {
  //       when(mockRepoService.addNewTask(any)).thenAnswer((_) async => Right(null));  // Use Right or your mechanism to handle futures
  //       await viewModel.createTask();
  //
  //       // Verify that the addNewTask was called on the RepoService
  //       verify(mockRepoService.addNewTask(any)).called(1);
  //     });
  //
  //     test('When createTask is called, should navigate back', () async {
  //       when(mockRepoService.addNewTask(any)).thenAnswer((_) async => Right(null));  // Adjust as per your error handling
  //       await viewModel.createTask();
  //
  //       // Verify that navigation back was called
  //       verify(mockNavigationService.back()).called(1);
  //     });
  //
  //     test('When setDateTime is called, deadline should be updated', () {
  //       final DateTime testDate = DateTime(2023, 1, 1);
  //       expect(viewModel.deadline, isNot(equals(testDate)));  // Initial check
  //
  //       viewModel.setDateTime(testDate);
  //       expect(viewModel.deadline, equals(testDate));  // After setting
  //     });
  //   });
  //
  //   group('updateTask -', () {
  //     test('When updateTask is called, should interact with RepoService', () async {
  //       TaskModel task = TaskModel(
  //         assignee: 'test-assignee',
  //         title: 'Original Title',
  //         id: 'task-id',
  //         done: false,
  //         details: 'Original Details',
  //         parentProjectId: 'project-id',
  //         deadline: DateTime.now(),
  //       );
  //
  //       when(mockRepoService.updateTask(any)).thenAnswer((_) async => Right(null));  // Adjust as needed
  //       await viewModel.updateTask(task);
  //
  //       // Verify that the updateTask was called on the RepoService
  //       verify(mockRepoService.updateTask(any)).called(1);
  //     });
  //   });
  // });
}
