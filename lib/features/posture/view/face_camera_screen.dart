import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/features/posture/controller/face_comera_controller.dart';
import 'package:matchster/features/posture/widgets/face_overlay_painter.dart';

class FaceCameraScreen extends StatelessWidget {
  FaceCameraScreen({super.key});
  final controller = Get.find<FaceCameraController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Face Detection'),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (!controller.isCameraInitialized.value ||
            controller.cameraController == null) {
          return Center(
            child: Text(
              controller.statusMessage.value,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final preview = controller.cameraController!;
        final previewSize = preview.value.previewSize;

        return Stack(
          children: [
            Positioned.fill(child: CameraPreview(preview)),

            if (previewSize != null)
              Positioned.fill(
                child: CustomPaint(
                  painter: FaceOverlayPainter(
                    face: controller.detectedFace.value,
                    imageSize: Size(previewSize.height, previewSize.width),
                    previewSize: MediaQuery.of(context).size,
                    isFrontCamera:
                        controller.selectedCamera?.lensDirection ==
                        CameraLensDirection.front,
                  ),
                ),
              ),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: 260,
                height: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        controller.isFaceCentered.value
                            ? Colors.green
                            : Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 120,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  controller.statusMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 40,
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isCaptureEnabled.value
                          ? () async {
                            final file = await controller.capturePhoto();
                            if (file != null) {
                              Get.snackbar(
                                'Success',
                                'Captured: ${file.path}',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          }
                          : null,
                  child: const Text('Capture'),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
