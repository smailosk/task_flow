import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/services/repo_service.dart';

// Creating mock classes for the services
class MockRepoService extends Mock implements RepoService {}

class MockNavigationService extends Mock implements NavigationService {}

// The locator instance used throughout your app
final GetIt locator = GetIt.instance;

// Register all mocked services
void registerServices() {
  locator.reset(); // Reset the locator to clear existing registrations
  locator.registerSingleton<RepoService>(MockRepoService());
  locator.registerSingleton<NavigationService>(MockNavigationService());
}

// Unregister or reset the services
void unregisterServices() {
  locator.reset(); // Clear all registered services
}
