import 'dart:io';
import 'dart:ui';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;

class FaceValidationResult {
  final bool isValid;
  final String message;
  final File? croppedFaceFile;

  const FaceValidationResult({
    required this.isValid,
    required this.message,
    this.croppedFaceFile,
  });
}

class FaceScanService {
  late final FaceDetector _faceDetector;

  FaceScanService() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: false,
        enableLandmarks: false,
        enableClassification: true,
        enableTracking: false,
        performanceMode: FaceDetectorMode.accurate,
        minFaceSize: 0.15,
      ),
    );
  }

  Future<void> dispose() async {
    await _faceDetector.close();
  }

  Future<FaceValidationResult> scanAndCropFace(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        return const FaceValidationResult(
          isValid: false,
          message: 'No face detected',
        );
      }

      if (faces.length > 1) {
        return const FaceValidationResult(
          isValid: false,
          message: 'Multiple faces detected. Show only one face.',
        );
      }

      final face = faces.first;

      final yaw = (face.headEulerAngleY ?? 0).abs();
      final roll = (face.headEulerAngleZ ?? 0).abs();
      final leftEye = face.leftEyeOpenProbability ?? 0;
      final rightEye = face.rightEyeOpenProbability ?? 0;

      if (yaw > 15 || roll > 15) {
        return const FaceValidationResult(
          isValid: false,
          message: 'Face must be front-facing',
        );
      }

      if (leftEye < 0.4 || rightEye < 0.4) {
        return const FaceValidationResult(
          isValid: false,
          message: 'Keep both eyes open',
        );
      }

      final cropped = await _cropFace(imageFile, face.boundingBox);

      if (cropped == null) {
        return const FaceValidationResult(
          isValid: false,
          message: 'Failed to crop face',
        );
      }

      return FaceValidationResult(
        isValid: true,
        message: 'Face is valid',
        croppedFaceFile: cropped,
      );
    } catch (e) {
      return FaceValidationResult(isValid: false, message: 'Scan error: $e');
    }
  }

  Future<File?> _cropFace(File imageFile, Rect boundingBox) async {
    final bytes = await imageFile.readAsBytes();
    final original = img.decodeImage(bytes);
    if (original == null) return null;

    int x = boundingBox.left.toInt();
    int y = boundingBox.top.toInt();
    int w = boundingBox.width.toInt();
    int h = boundingBox.height.toInt();

    // Add some padding around face.
    final padX = (w * 0.20).toInt();
    final padY = (h * 0.25).toInt();

    x = (x - padX).clamp(0, original.width - 1);
    y = (y - padY).clamp(0, original.height - 1);

    w = (w + padX * 2).clamp(1, original.width - x);
    h = (h + padY * 2).clamp(1, original.height - y);

    final cropped = img.copyCrop(original, x: x, y: y, width: w, height: h);

    final tempPath = '${imageFile.parent.path}/cropped_face.jpg';
    final croppedFile = File(tempPath);
    await croppedFile.writeAsBytes(img.encodeJpg(cropped, quality: 95));
    return croppedFile;
  }
}
