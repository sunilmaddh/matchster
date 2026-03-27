import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:path_provider/path_provider.dart';

class CropGridOverlay extends StatelessWidget {
  const CropGridOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: SizedBox.expand(child: CustomPaint(painter: _GridPainter())),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.7)
          ..strokeWidth = 1;

    final thirdW = size.width / 3;
    final thirdH = size.height / 3;

    for (int i = 1; i <= 2; i++) {
      canvas.drawLine(
        Offset(thirdW * i, 0),
        Offset(thirdW * i, size.height),
        paint,
      );
      canvas.drawLine(
        Offset(0, thirdH * i),
        Offset(size.width, thirdH * i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class ProfilePhotoPreviewScreen extends StatefulWidget {
  final File imageFile;

  const ProfilePhotoPreviewScreen({super.key, required this.imageFile});

  @override
  State<ProfilePhotoPreviewScreen> createState() =>
      _ProfilePhotoPreviewScreenState();
}

class _ProfilePhotoPreviewScreenState extends State<ProfilePhotoPreviewScreen> {
  final GlobalKey _cropKey = GlobalKey();

  final _profileController = Get.find<ProfileController>();

  Offset _offset = Offset.zero;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding + 20.verticalPadding,
        child: Obx(() {
          if (_profileController.isImageUploading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }
          return AppButton(
            name: "Upload",
            isEnable: true,
            onTop: () async {
              try {
                _profileController.isImageUploading.value = true;
                final file = await _cropImage();
                _profileController.validateAndUploadPhoto(file: file);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          );
        }),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: Get.back,
                    ),
                  ),
                ),
                CommonText.text("Crop photo", fontWeight: FontWeight.w400),
              ],
            ),

            /// 🔥 Crop Area
            Center(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    RepaintBoundary(
                      key: _cropKey,
                      child: GestureDetector(
                        onScaleUpdate: (details) {
                          setState(() {
                            // zoom
                            _scale = (_scale * details.scale).clamp(1.0, 4.0);

                            // move (single finger)
                            _offset += details.focalPointDelta;
                          });
                        },
                        onScaleEnd: (_) {
                          // optional: snap back if scale < 1
                          if (_scale < 1) {
                            setState(() {
                              _scale = 1;
                              _offset = Offset.zero;
                            });
                          }
                        },
                        child: ClipRect(
                          child: Transform(
                            alignment: Alignment.center,
                            transform:
                                Matrix4.identity()
                                  ..translate(_offset.dx, _offset.dy)
                                  ..scale(_scale),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.file(
                                  widget.imageFile,
                                  fit: BoxFit.cover,
                                  cacheWidth: 600,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const CropGridOverlay(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> _cropImage() async {
    final context = _cropKey.currentContext;
    if (context == null) {
      throw Exception('Crop area not ready');
    }
    final boundary = context.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final pngBytes = byteData!.buffer.asUint8List();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/cropped.png');

    await file.writeAsBytes(pngBytes);
    return file;
  }
}
