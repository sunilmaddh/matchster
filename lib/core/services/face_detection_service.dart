// import 'dart:io';
// import 'dart:ui';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

// class FaceDetectionService {
//   FaceDetector? _detector;

//   FaceDetectionService() {
//     _detector = FaceDetector(
//       options: FaceDetectorOptions(
//         performanceMode: FaceDetectorMode.accurate,
//         enableContours: false,
//         enableLandmarks: false,
//         enableClassification: false,
//         enableTracking: false,
//       ),
//     );
//   }

//   Future<Face?> detectPrimaryFace(File imageFile) async {
//     final inputImage = InputImage.fromFile(imageFile);
//     final faces = await _detector!.processImage(inputImage);
//     if (faces.isEmpty) return null;
//     // Pick the largest face as "primary"
//     faces.sort((a, b) => b.boundingBox.area.compareTo(a.boundingBox.area));
//     return faces.first;
//   }

//   void dispose() {
//     _detector?.close();
//   }
// }

// extension _RectArea on Rect {
//   double get area => width * height;
// }
