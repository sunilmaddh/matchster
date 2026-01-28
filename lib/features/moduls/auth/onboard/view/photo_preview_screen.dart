// import 'dart:io';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class CropGridOverlay extends StatelessWidget {
  const CropGridOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox.expand(child: CustomPaint(painter: _GridPainter())),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1;

    final thirdWidth = size.width / 3;
    final thirdHeight = size.height / 3;

    // Vertical lines
    canvas.drawLine(
      Offset(thirdWidth, 0),
      Offset(thirdWidth, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(thirdWidth * 2, 0),
      Offset(thirdWidth * 2, size.height),
      paint,
    );

    // Horizontal lines
    canvas.drawLine(
      Offset(0, thirdHeight),
      Offset(size.width, thirdHeight),
      paint,
    );
    canvas.drawLine(
      Offset(0, thirdHeight * 2),
      Offset(size.width, thirdHeight * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PhotoPreviewScreen extends StatefulWidget {
  final File imageFile;
  final int index;
  const PhotoPreviewScreen({
    super.key,
    required this.imageFile,
    required this.index,
  });

  @override
  State<PhotoPreviewScreen> createState() => _CustomCropScreenState();
}

class _CustomCropScreenState extends State<PhotoPreviewScreen> {
  final TransformationController _controller = TransformationController();
  final GlobalKey _cropKey = GlobalKey();
  final _onboarController = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding + 20.verticalPadding,
        child: Obx(
          () =>
              _onboarController.isImageUploading.isTrue
                  ? CircularProgressIndicator()
                  : AppButton(
                    name: "Upload",
                    onTop: () async {
                      _onboarController.isImageUploading(true);
                      final file = await _cropImage();
                      _onboarController.validateAndUploadPhoto(
                        file: file,
                        index: widget.index,
                      );
                    },
                    isEnable: true,
                  ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Close
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ),
            ),

            /// Crop Area
            Center(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    RepaintBoundary(
                      key: _cropKey,
                      child: InteractiveViewer(
                        transformationController: _controller,
                        minScale: 1,
                        maxScale: 4,
                        child: Image.file(
                          widget.imageFile,
                          fit: BoxFit.cover,
                          cacheWidth: 600, // VERY IMPORTANT for Vivo
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),

                    const CropGridOverlay(),
                  ],
                ),
              ),
            ),

            /// Upload
          ],
        ),
      ),
    );
  }

  Future<File> _cropImage() async {
    final boundary =
        _cropKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 3);

    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final filePath = path.join(directory.path, 'cropped.png');

    final file = File(filePath);
    await file.writeAsBytes(pngBytes);

    return file;
  }
}
