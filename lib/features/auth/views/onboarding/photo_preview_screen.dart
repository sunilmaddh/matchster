import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/photo_review_bottomsheet.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PhotoPreviewScreen extends StatefulWidget {
  const PhotoPreviewScreen({super.key});

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  final GlobalKey _cropKey = GlobalKey();
  final OnboardController _onboardController = Get.find<OnboardController>();

  late final File _imageFile;
  late final int _index;
  late final String _page;

  Offset _offset = Offset.zero;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    final args = (Get.arguments as Map<String, dynamic>?) ?? {};
    final image = args['image'];
    _imageFile = image is File ? image : File('');
    _index = args['index'] is int ? args['index'] as int : 0;
    _page = args['page']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (_imageFile.path.isEmpty) {
      return const Scaffold(body: Center(child: Text('Image not found')));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding + 20.verticalPadding,
        child: Obx(() {
          if (_onboardController.isImageUploading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }
          return AppButton(
            name: "Upload",
            isEnable: true,
            onTop: () async {
              try {
                final file = await _cropImage();
                await _onboardController.validateAndUploadPhoto(
                  file: file,
                  index: _index,
                );
                if (_onboardController.showPhotoReview.isTrue) {
                  PhotoReviewBottomsheet.show(
                    onImageSelected: (selectedImage) {
                      AppNavigation.back();
                      AppNavigation.to(
                        AppRoutes.profilePreviewScreen,
                        arguments: {
                          "image": selectedImage,
                          "index": _onboardController.failedIndex ?? _index,
                          "page": _page,
                        },
                      );
                      _onboardController.showPhotoReview.value = false;
                    },
                  );
                }
              } catch (e) {
                AppToastMessage.show(
                  title: 'Error',
                  message: e.toString(),
                  isError: true,
                );
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
                            _scale = (_scale * details.scale).clamp(1.0, 4.0);
                            _offset += details.focalPointDelta;
                          });
                        },
                        onScaleEnd: (_) {
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
                                  _imageFile,
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

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      throw Exception('Crop boundary not found');
    }

    final image = await renderObject.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Failed to crop image');
    }

    final pngBytes = byteData.buffer.asUint8List();
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    await file.writeAsBytes(pngBytes);
    return file;
  }
}
