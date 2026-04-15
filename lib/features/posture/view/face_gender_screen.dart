import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:matchster/features/posture/models/gender_prediction_result.dart';
import 'package:matchster/features/posture/services/face_scan_service.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceGenderScreen extends StatefulWidget {
  const FaceGenderScreen({super.key});

  @override
  State<FaceGenderScreen> createState() => _FaceGenderScreenState();
}

class _FaceGenderScreenState extends State<FaceGenderScreen> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];

  final FaceScanService _faceScanService = FaceScanService();
  final GenderModelService _genderModelService = GenderModelService();

  bool _isInitialized = false;
  bool _isProcessing = false;

  File? _capturedImage;
  File? _croppedFaceImage;

  String _status = 'Initializing...';
  String _gender = '';
  double? _confidence;
  Map<String, double> _scores = {};

  @override
  void initState() {
    super.initState();
    _initAll();
  }

  Future<void> _initAll() async {
    try {
      final granted = await _requestCameraPermission();
      if (!granted) {
        setState(() {
          _status = 'Camera permission denied';
        });
        return;
      }

      await _genderModelService.loadModel();
      _cameras = await availableCameras();

      final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() {
        _isInitialized = true;
        _status = 'Ready. Align face and tap Scan';
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _status = 'Initialization failed: $e';
      });
    }
  }

  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<void> _captureAndScan() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isProcessing) {
      return;
    }

    setState(() {
      _isProcessing = true;
      _status = 'Capturing image...';
      _gender = '';
      _confidence = null;
      _scores = {};
    });

    try {
      final xFile = await _cameraController!.takePicture();
      final imageFile = File(xFile.path);

      setState(() {
        _capturedImage = imageFile;
        _status = 'Scanning face...';
      });

      final faceResult = await _faceScanService.scanAndCropFace(imageFile);

      if (!faceResult.isValid || faceResult.croppedFaceFile == null) {
        setState(() {
          _status = faceResult.message;
          _croppedFaceImage = null;
        });
        return;
      }

      setState(() {
        _croppedFaceImage = faceResult.croppedFaceFile;
        _status = 'Predicting gender...';
      });

      final prediction = await _genderModelService.predictFromFaceFile(
        faceResult.croppedFaceFile!,
      );

      setState(() {
        _gender = prediction.label;
        _confidence = prediction.confidence;
        _scores = prediction.scores;
        _status = 'Done';
      });
    } catch (e) {
      debugPrint('Processing failed: $e');
      setState(() {
        _status = 'Processing failed: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceScanService.dispose();
    _genderModelService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final previewReady =
        _isInitialized &&
        _cameraController != null &&
        _cameraController!.value.isInitialized;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Scan + Gender POC'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child:
                  previewReady
                      ? Stack(
                        alignment: Alignment.center,
                        children: [
                          CameraPreview(_cameraController!),
                          Container(
                            width: 240,
                            height: 320,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      )
                      : Center(
                        child: Text(
                          _status,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      _status,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _isProcessing ? null : _captureAndScan,
                      child: Text(_isProcessing ? 'Processing...' : 'Scan'),
                    ),
                    const SizedBox(height: 20),

                    if (_capturedImage != null) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Captured image',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _capturedImage!,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (_croppedFaceImage != null) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Cropped face',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _croppedFaceImage!,
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (_gender.isNotEmpty) ...[
                      Text(
                        'Prediction: $_gender',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_confidence != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Confidence: ${(_confidence! * 100).toStringAsFixed(2)}%',
                          ),
                        ),
                      const SizedBox(height: 12),
                      if (_scores.isNotEmpty)
                        Column(
                          children:
                              _scores.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    '${entry.key}: ${(entry.value * 100).toStringAsFixed(2)}%',
                                  ),
                                );
                              }).toList(),
                        ),
                      const SizedBox(height: 12),
                      const Text(
                        'Use this only as a model prediction, not as a strict identity check.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
