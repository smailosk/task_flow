import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.bottomsheets.dart';
import 'package:task_flow/app/app.dialogs.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      builder: (context, child) =>
          SafeArea(child: child ?? const SizedBox.shrink()),
    );
  }
}
