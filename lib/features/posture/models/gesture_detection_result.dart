import 'package:hand_landmarker/hand_landmarker.dart';

class GestureDetectionResult {
  final bool isGestureValid;
  final String status;
  final List<Hand> hands;

  const GestureDetectionResult({
    required this.isGestureValid,
    required this.status,
    required this.hands,
  });
}
