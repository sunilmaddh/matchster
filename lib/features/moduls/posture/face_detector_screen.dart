import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/features/moduls/profile/services/face_detector_service.dart';

class FaceDetectorScreen extends StatefulWidget {
  const FaceDetectorScreen({super.key});

  @override
  State<FaceDetectorScreen> createState() => _FaceCameraScreenState();
}

class _FaceCameraScreenState extends State<FaceDetectorScreen> {
  late CameraController _controller;
  final FaceDetectorService _faceService = FaceDetectorService();
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      CameraDescription(
        name: "front",
        lensDirection: CameraLensDirection.front,
        sensorOrientation: 1,
      ),
      // cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _controller.initialize().then((_) {
      _controller.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  void _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    final inputImage = InputImage.fromBytes(
      bytes: image.planes.first.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );

    final faces = await _faceService.detectFaces(inputImage);

    if (faces.isNotEmpty) {
      debugPrint("Face detected: ${faces.length}");
    }

    _isDetecting = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(body: Stack(children: [CameraPreview(_controller)]));
  }
}
