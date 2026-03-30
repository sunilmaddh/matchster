import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUploadServices {
  final ImagePicker _picker = ImagePicker();

  Future<File?> getImageFromCamera({
    int imageQuality = 85,
    CameraDevice preferredCameraDevice = CameraDevice.front,
  }) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );

    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  Future<File?> getImageFromGallery({int imageQuality = 85}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );

    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }
}
