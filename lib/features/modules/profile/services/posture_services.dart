import 'package:flutter/services.dart';

class PostureService {
  static const platform = MethodChannel('posture/camera');

  static Future<void> startCameraActivity() async {
    try {
      final result = await platform.invokeMethod('startPostureCamera');
      print("hand $result"); // "Camera Activity Launched"
    } on PlatformException catch (e) {
      print("Failed to launch camera: '${e.message}'.");
    }
  }
}
