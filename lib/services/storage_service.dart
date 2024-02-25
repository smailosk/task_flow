import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:task_flow/core/error_handling/failures/general_failure.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  StorageService() {
    _storage.useStorageEmulator('127.0.0.1', 9199);
  }

  Future<String> uploadProfilePicture(Uint8List data, String userId) async {
    try {
      final fileName = '$userId.jpg'; // Specify the desired file name here

      final result = await _storage.ref('profile_pictures/$fileName').putData(
            data,
          );
      return await result.ref.getDownloadURL();
    } catch (e) {
      throw GeneralFailure();
    }
  }

  Future<String?> getProfilePictureUrl(String userId) async {
    try {
      final url =
          await _storage.ref('profile_pictures/$userId.jpg').getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
