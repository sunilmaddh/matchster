import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image/image.dart' as img;

class ImageUploadServices {
  final ImagePicker _picker = ImagePicker();
  late File imagePath = File("");

  Future<File?> pickImageFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return null; // User canceled
    return File(image.path);
  }

  Future<File?> pickImageFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null; // User canceled
    return File(image.path);
  }

  Future<File?> getImageFromCamera() async {
    try {
      File? file = await pickImageFromCamera();
      if (file != null) {
        imagePath = await fixExifRotation(file);
      }
      return imagePath;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<File?> getImageFromGallery() async {
    try {
      File? file = await pickImageFromGallery();
      if (file != null) {
        imagePath = await fixExifRotation(file);
      }
      return imagePath;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<File> fixExifRotation(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return file;
    final fixed = img.bakeOrientation(image);
    return await file.writeAsBytes(img.encodeJpg(fixed));
  }
}
