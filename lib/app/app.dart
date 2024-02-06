import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:task_flow/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:task_flow/ui/views/home/home_view.dart';
import 'package:task_flow/ui/views/startup/startup_view.dart';
import 'package:task_flow/ui/views/login/login_view.dart';
import 'package:task_flow/ui/views/environment/environment_view.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/services/google_auth_service.dart';
import 'package:task_flow/services/functions_service.dart';
import 'package:task_flow/services/repo_service.dart';
import 'package:task_flow/services/firestore_service.dart';
import 'package:task_flow/ui/views/add_environment/add_environment_view.dart';
import 'package:task_flow/ui/views/settings/settings_view.dart';
import 'package:task_flow/ui/views/calendar/calendar_view.dart';
import 'package:task_flow/ui/views/projects/projects_view.dart';
import 'package:task_flow/ui/views/add_project/add_project_view.dart';
import 'package:task_flow/ui/views/todo_tasks/todo_tasks_view.dart';
import 'package:task_flow/ui/views/add_todo_task/add_todo_task_view.dart';
import 'package:task_flow/ui/views/profile/profile_view.dart';
// @stacked-import

//  flutter clean && flutter pub get && stacked generate
//  flutter clean && flutter pub get && flutter build apk --release --split-per-abi
//  flutter clean && flutter pub get && flutter build appbundle --release
//  flutter clean && flutter pub get && flutter build ios
//  flutter clean && flutter pub get && flutter build ipa --release
//  flutter clean && flutter pub get && flutter build web --web-renderer canvaskit --release && firebase deploy
//  flutter clean && flutter pub get && flutter pub outdated

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: EnvironmentView),
    MaterialRoute(page: AddEnvironmentView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: CalendarView),
    MaterialRoute(page: ProjectsView),
    MaterialRoute(page: AddProjectView),
    MaterialRoute(page: TodoTasksView),
    MaterialRoute(page: AddTodoTaskView),
    MaterialRoute(page: ProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),

    LazySingleton(classType: AuthService),
    LazySingleton(classType: GoogleAuthService),
    LazySingleton(classType: FunctionsService),
    LazySingleton(classType: RepoService),
    LazySingleton(classType: FirestoreService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
