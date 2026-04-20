class FaceDetectionResult {
  final bool isFaceDetected;
  final bool isFaceValid;
  final String status;

  const FaceDetectionResult({
    required this.isFaceDetected,
    required this.isFaceValid,
    required this.status,
  });
}
