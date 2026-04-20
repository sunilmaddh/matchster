import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/features/posture/models/face_detection_result.dart';
import 'package:matchster/features/posture/services/face/i_posture_face_detection_service.dart';

class PostureFaceDetectionService implements IFaceDetectionService {
  FaceDetector? _faceDetector;

  @override
  Future<void> initialize() async {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: false,
        enableContours: false,
        enableLandmarks: false,
        enableTracking: false,
        minFaceSize: 0.1,
        performanceMode: FaceDetectorMode.fast,
      ),
    );
  }

  @override
  Future<FaceDetectionResult> detectFace({
    required CameraImage image,
    required int sensorOrientation,
  }) async {
    try {
      final InputImage? inputImage = _convertCameraImageToInputImage(
        image: image,
        sensorOrientation: sensorOrientation,
      );

      if (inputImage == null) {
        return const FaceDetectionResult(
          isFaceDetected: false,
          isFaceValid: false,
          status: 'Unable to read face',
        );
      }

      final List<Face> faces = await _faceDetector!.processImage(inputImage);

      if (faces.isEmpty) {
        return const FaceDetectionResult(
          isFaceDetected: false,
          isFaceValid: false,
          status: 'No face detected',
        );
      }

      if (faces.length > 1) {
        return const FaceDetectionResult(
          isFaceDetected: false,
          isFaceValid: false,
          status: 'Multiple faces detected',
        );
      }

      final Face face = faces.first;
      final bool faceSizeValid =
          face.boundingBox.width > 80 && face.boundingBox.height > 80;

      return FaceDetectionResult(
        isFaceDetected: true,
        isFaceValid: faceSizeValid,
        status: faceSizeValid ? 'Face detected' : 'Move closer to the camera',
      );
    } catch (e) {
      debugPrint('FACE DETECTION ERROR -> $e');
      return const FaceDetectionResult(
        isFaceDetected: false,
        isFaceValid: false,
        status: 'Face detection failed',
      );
    }
  }

  InputImage? _convertCameraImageToInputImage({
    required CameraImage image,
    required int sensorOrientation,
  }) {
    try {
      final InputImageRotation rotation =
          InputImageRotationValue.fromRawValue(sensorOrientation) ??
          InputImageRotation.rotation0deg;

      final Uint8List nv21Bytes = _yuv420ToNv21(image);

      return InputImage.fromBytes(
        bytes: nv21Bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: InputImageFormat.nv21,
          bytesPerRow: image.width,
        ),
      );
    } catch (e) {
      debugPrint('INPUT IMAGE ERROR -> $e');
      return null;
    }
  }

  Uint8List _yuv420ToNv21(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final int ySize = width * height;
    final int uvSize = width * height ~/ 4;
    final Uint8List out = Uint8List(ySize + uvSize * 2);

    int offset = 0;

    final Plane yPlane = image.planes[0];
    for (int row = 0; row < height; row++) {
      final int rowStart = row * yPlane.bytesPerRow;
      out.setRange(offset, offset + width, yPlane.bytes, rowStart);
      offset += width;
    }

    final Plane uPlane = image.planes[1];
    final Plane vPlane = image.planes[2];

    final int uvWidth = width ~/ 2;
    final int uvHeight = height ~/ 2;

    final int uPixelStride = uPlane.bytesPerPixel ?? 1;
    final int vPixelStride = vPlane.bytesPerPixel ?? 1;

    for (int row = 0; row < uvHeight; row++) {
      for (int col = 0; col < uvWidth; col++) {
        final int uIndex = row * uPlane.bytesPerRow + col * uPixelStride;
        final int vIndex = row * vPlane.bytesPerRow + col * vPixelStride;

        if (uIndex < uPlane.bytes.length && vIndex < vPlane.bytes.length) {
          out[offset++] = vPlane.bytes[vIndex];
          out[offset++] = uPlane.bytes[uIndex];
        }
      }
    }

    return out;
  }

  @override
  Future<void> dispose() async {
    await _faceDetector?.close();
    _faceDetector = null;
  }
}
