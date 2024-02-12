import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/ui/views/edit_profile/edit_profile_view.dart';
import 'package:task_flow/ui/views/environment/environment_view.dart';
import 'package:task_flow/ui/views/login/login_view.dart';
import 'package:task_flow/ui/views/settings/settings_view.dart';
import 'package:task_flow/ui/views/sign_up/sign_up_view.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.indicator,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(30)),
        // ),
        snakeViewColor: const Color(0xFF24A19C),
        selectedItemColor: const Color(0xFF24A19C),
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile')
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      body: getViewByIndex(viewModel.currentIndex),
    );
  }

  Widget getViewByIndex(int index) {
    Widget widget = Container(
      color: Colors.white,
    );

    switch (index) {
      case 0:
        widget = const EnvironmentView();
      case 1:
        widget = const Placeholder();
      case 2:
        widget = const SignUpView();
      case 3:
        widget = const SettingsView();
    }
    return widget;
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
