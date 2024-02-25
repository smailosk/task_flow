import 'dart:typed_data';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/services/image_picker_service.dart';
import 'package:task_flow/services/storage_service.dart';
import 'package:task_flow/ui/views/edit_profile/edit_profile_view.dart';
import 'package:task_flow/ui/views/edit_profile/edit_profile_view.form.dart';

class EditProfileViewModel extends FormViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _log = getLogger('EditProfileViewModel');
  final _picker = locator<ImagePickerService>();
  final _storage = locator<StorageService>();

  String get uid => _authService.uid!;
  init() async {
    setBusy(true);
    final user = await _authService.currentUser;

    if (user != null) {
      emailValue = user.email;
      userNameValue = user.displayName;
      initialUserName = userNameValue ?? '';
      passwordValue = '*********';
      final url = await _storage.getProfilePictureUrl(_authService.uid!);
      if (url != null) _imgUrl = url;
    }
    setBusy(false);
  }

  String initialUserName = '';
  bool _isEditingPassword = false;
  bool get isEditingPassword => _isEditingPassword;

  String _imgUrl = 'https://i.pravatar.cc/1000';
  String get imgUrl => _imgUrl;

  bool get userNameUpdated => userNameValue != initialUserName;

  _setIsEditingPassword(bool value) {
    if (value == true) {
      passwordValue = '';
    } else {
      passwordValue = '*********';
    }
    _isEditingPassword = value;
    notifyListeners();
  }

  editPassword() {
    _log.i('');
    if (!_isEditingPassword) {
      _setIsEditingPassword(true);
    }
  }

  savePassword() {
    setBusyForObject('password', true);
    _log.i(passwordValue);
    if (passwordValue == null) {
      _log.i('passwordValue is null');

      return;
    }
    // validateForm();
    // if (hasAnyValidationMessage) return;
    _authService.updatePassword(passwordValue!).executeFuture((onError) {
      _log.e(onError);
      setBusyForObject('password', false);

      _setIsEditingPassword(false);
    }, (onSuccess) {
      _log.i('Password updated');
      setBusyForObject('password', false);

      _setIsEditingPassword(false);
    });
  }

  changeUsername() {
    _authService.updateUsername(userNameValue!).executeFuture((onError) {
      _log.e(onError);
    }, (onSuccess) {
      initialUserName = userNameValue!;
      notifyListeners();
      _log.i('Username updated');
    });
  }

  back() {
    _navigationService.back();
  }

  _takePicture() {
    setBusyForObject('img', true);
    Executor.runFuture(_picker.takePhoto()).then((value) => value.fold((l) {
          setBusy(false);
        }, (image) async {
          if (image != null) {
            final bytes = await image.readAsBytes();
            _updateProfilePicture(bytes);
          }
          setBusy(false);
        }));
  }

  _pickImageFromGallery() {
    setBusyForObject('img', true);
    Executor.runFuture(_picker.pickFromGallery())
        .then((value) => value.fold((l) {
              setBusy(false);
            }, (image) async {
              if (image != null) {
                final bytes = await image.readAsBytes();
                _updateProfilePicture(bytes);
              }
            }));
  }

  _updateProfilePicture(Uint8List bytes) {
    _storage.uploadProfilePicture(bytes, _authService.uid!).executeFuture(
        (onError) {
      setBusyForObject('img', false);
    }, (onSucuess) {
      _imgUrl = onSucuess;
      setBusyForObject('img', false);
    });
  }

  changeProfilePicture(ProfilePictureAction value) async {
    setBusy(true);
    switch (value) {
      case ProfilePictureAction.takeAPicture:
        _takePicture();
        break;
      case ProfilePictureAction.chooseFromGallery:
        _pickImageFromGallery();
        break;
    }
  }
}
