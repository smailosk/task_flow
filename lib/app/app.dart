import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/services/geolocation_service.dart';
import 'package:task_flow/services/weather_api_service.dart';
import 'package:task_flow/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:task_flow/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:task_flow/ui/views/categories/categories_view.dart';
import 'package:task_flow/ui/views/home/home_view.dart';
import 'package:task_flow/ui/views/start_page/get_start_page_view.dart';
import 'package:task_flow/ui/views/startup/startup_view.dart';
import 'package:task_flow/ui/views/weather/weather_view.dart';
import 'package:task_flow/ui/views/login/login_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: WeatherView),
    MaterialRoute(page: CategoriesView),
    MaterialRoute(page: GetStartPageView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: WeatherApiService),
    LazySingleton(classType: GeolocationService),
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
