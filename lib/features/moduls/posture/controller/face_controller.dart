import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceController extends GetxController {
  late CameraController cameraController;
  late FaceDetector faceDetector;

  late CameraDescription cameraDescription; // 👈 ADD THIS

  Interpreter? interpreter;

  var faces = <Face>[].obs;
  var isProcessing = false.obs;
  var similarity = 0.0.obs;

  bool _isBusy = false;
  var isCameraInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initCamera();
    loadModel();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );

    cameraController = CameraController(
      front,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await cameraController.initialize();
    isCameraInitialized.value = true;
    startImageStream();
  }

  void loadModel() async {
    interpreter = await Interpreter.fromAsset('models/mobile_face_net.tflite');

    faceDetector = FaceDetector(
      options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast),
    );
  }

  void startImageStream() {
    cameraController.startImageStream((image) async {
      if (_isBusy) return;
      _isBusy = true;

      await processImage(image);

      _isBusy = false;
    });
  }

  Future<void> processImage(CameraImage image) async {
    final inputImage = _convertToInputImage(image);

    final detectedFaces = await faceDetector.processImage(inputImage);

    faces.value = detectedFaces;

    if (detectedFaces.isNotEmpty) {
      final embedding = await generateEmbedding(image, detectedFaces.first);
      compareWithStored(embedding);
    }
  }

  Future<List<double>> generateEmbedding(CameraImage image, Face face) async {
    // TODO: Crop face and resize to 112x112
    // This should be done properly using image package

    var input = List.generate(
      1 * 112 * 112 * 3,
      (i) => 0.0,
    ).reshape([1, 112, 112, 3]);

    var output = List.filled(128, 0.0).reshape([1, 128]);

    interpreter?.run(input, output);

    return output[0];
  }

  void compareWithStored(List<double> current) {
    // Example dummy stored embedding
    List<double> stored = List.filled(128, 0.5);

    double sim = cosineSimilarity(current, stored);
    similarity.value = sim;

    if (sim > 0.7) {
      print("MATCHED");
    }
  }

  double cosineSimilarity(List<double> e1, List<double> e2) {
    double dot = 0;
    double norm1 = 0;
    double norm2 = 0;

    for (int i = 0; i < e1.length; i++) {
      dot += e1[i] * e2[i];
      norm1 += e1[i] * e1[i];
      norm2 += e2[i] * e2[i];
    }

    return dot / (sqrt(norm1) * sqrt(norm2));
  }

  InputImage _convertToInputImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();

    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final imageRotation =
        InputImageRotationValue.fromRawValue(
          cameraDescription.sensorOrientation,
        ) ??
        InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
        InputImageFormat.nv21;

    final metadata = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation,
      format: inputImageFormat,
      bytesPerRow: image.planes.first.bytesPerRow,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: metadata);
  }

  @override
  void onClose() {
    cameraController.dispose();
    interpreter?.close();
    faceDetector.close();
    super.onClose();
  }
}
