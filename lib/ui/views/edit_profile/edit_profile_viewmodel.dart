import 'package:stacked/stacked.dart';
import 'package:task_flow/ui/views/edit_profile/edit_profile_view.form.dart';

class EditProfileViewModel extends FormViewModel {
  changeData() {
    final name = fullNameValue;
    fullNameValue = 'test';

    notifyListeners();
  }
}
