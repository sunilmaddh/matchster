import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceOverlayPainter extends CustomPainter {
  const FaceOverlayPainter({
    required this.face,
    required this.imageSize,
    required this.previewSize,
    required this.isFrontCamera,
  });

  final Face? face;
  final Size imageSize;
  final Size previewSize;
  final bool isFrontCamera;

  @override
  void paint(Canvas canvas, Size size) {
    if (face == null) return;

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = Colors.green;

    final rect = _scaleRect(
      rect: face!.boundingBox,
      imageSize: imageSize,
      widgetSize: previewSize,
      flipX: isFrontCamera,
    );

    canvas.drawRect(rect, paint);
  }

  Rect _scaleRect({
    required Rect rect,
    required Size imageSize,
    required Size widgetSize,
    required bool flipX,
  }) {
    final scaleX = widgetSize.width / imageSize.width;
    final scaleY = widgetSize.height / imageSize.height;

    double left = rect.left * scaleX;
    double top = rect.top * scaleY;
    double right = rect.right * scaleX;
    double bottom = rect.bottom * scaleY;

    if (flipX) {
      final newLeft = widgetSize.width - right;
      final newRight = widgetSize.width - left;
      left = newLeft;
      right = newRight;
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
