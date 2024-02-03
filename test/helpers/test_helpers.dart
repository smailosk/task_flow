import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/services/google_auth_service.dart';
import 'package:task_flow/services/functions_service.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/services/firestore_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<RouterService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GoogleAuthService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FunctionsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<RepoService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FirestoreService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterFunctionsService();
  getAndRegisterRepoService();
  getAndRegisterFirestoreService();
// @stacked-mock-register
}
