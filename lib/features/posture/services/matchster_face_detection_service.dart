import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class MatchsterFaceDetectionService {
  MatchsterFaceDetectionService()
    : _detector = FaceDetector(
        options: FaceDetectorOptions(
          performanceMode: FaceDetectorMode.fast,
          enableContours: false,
          enableLandmarks: false,
          enableClassification: true,
          enableTracking: true,
          minFaceSize: 0.15,
        ),
      );

  final FaceDetector _detector;

  Future<List<Face>> detectFaces(InputImage inputImage) async {
    return _detector.processImage(inputImage);
  }

  Future<void> dispose() async {
    await _detector.close();
  }
}
