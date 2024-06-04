import 'package:mockito/annotations.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/services/repo_service.dart';

import 'test_helpers.mocks.dart';

@GenerateNiceMocks([MockSpec<RepoService>(), MockSpec<NavigationService>()])
void registerServices() {
  final locator = StackedLocator.instance;

  locator.registerSingleton<RepoService>(MockRepoService());
  locator.registerSingleton<NavigationService>(MockNavigationService());
}

void unregisterServices() {
  final locator = StackedLocator.instance;

  locator.unregister<RepoService>();
  locator.unregister<NavigationService>();
}
