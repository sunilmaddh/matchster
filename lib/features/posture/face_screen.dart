import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/features/posture/controller/face_controller.dart';

class FaceCameraScreen extends StatelessWidget {
  final controller = Get.find<FaceController>();

  FaceCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            AspectRatio(
              aspectRatio: controller.cameraController.value.aspectRatio,
              child: CameraPreview(controller.cameraController),
            ),

            Positioned.fill(
              child: CustomPaint(
                painter: FacePainter(
                  controller.faces,
                  controller.cameraController.value.previewSize!,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Obx(
                () => Center(
                  child: Text(
                    "Similarity: ${controller.similarity.value.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 22,
                      color:
                          controller.similarity.value > 0.7
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;

  FacePainter(this.faces, this.imageSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;

    // Use actual canvas size instead of screen size
    final scaleX = size.width / imageSize.height;
    final scaleY = size.height / imageSize.width;

    for (var face in faces) {
      final rect = face.boundingBox;

      final scaledRect = Rect.fromLTRB(
        rect.left * scaleX,
        rect.top * scaleY,
        rect.right * scaleX,
        rect.bottom * scaleY,
      );

      canvas.drawRect(scaledRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
