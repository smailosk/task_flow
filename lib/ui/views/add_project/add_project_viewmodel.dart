import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class AddProjectViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _colors = <String>[];

  List<String> get colors => _colors;

  // void updateSelectedColor(int index) {
  //   environmentColorValue = _colors[index];
  //   _selectedColorIndex = index;
  //   notifyListeners();
  // }
  back() {
    _navigationService.back();
  }
}
