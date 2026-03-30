import 'dart:io';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectionService {
  late final FaceDetector _faceDetector;

  FaceDetectionService() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableLandmarks: true,
        enableClassification: true,
        enableContours: true,
        performanceMode: FaceDetectorMode.accurate,
        minFaceSize: 0.15,
      ),
    );
  }

  Future<List<Face>> detectFaces(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    return await _faceDetector.processImage(inputImage);
  }

  Future<Face?> detectPrimaryFace(File imageFile) async {
    final faces = await detectFaces(imageFile);
    if (faces.isEmpty) return null;
    return faces.first;
  }

  Future<bool> hasSingleFace(File imageFile) async {
    final faces = await detectFaces(imageFile);
    return faces.length == 1;
  }

  Future<bool> isFaceClear(File imageFile) async {
    final faces = await detectFaces(imageFile);

    if (faces.length != 1) return false;

    final face = faces.first;

    final leftEyeOpen = (face.leftEyeOpenProbability ?? 0) >= 0.5;
    final rightEyeOpen = (face.rightEyeOpenProbability ?? 0) >= 0.5;
    final isLookingStraight =
        (face.headEulerAngleY ?? 0).abs() <= 15 &&
        (face.headEulerAngleZ ?? 0).abs() <= 15;

    return leftEyeOpen && rightEyeOpen && isLookingStraight;
  }

  void dispose() {
    _faceDetector.close();
  }
}
