import 'package:image_picker/image_picker.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';

class ImagePickerService {
  final _picker = ImagePicker();
  // final _log = getLogger('ImagePickerService');
  static const int _imageQuality = 100;
  Future<XFile?> pickFromGallery() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: _imageQuality);

      return image;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'Picking image from gallery failed: ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }

  Future<XFile?> takePhoto() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: _imageQuality,
      );

      return image;
    } catch (exception, stackTrace) {
      throw GeneralFailure(
          type: GeneralFailureType.unexpectedError,
          description:
              'Picking image from camera failed: ${exception.toString()}',
          stackTrace: stackTrace);
    }
  }
}
