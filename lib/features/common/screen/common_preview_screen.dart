import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/crop_grid_overlay.dart'
    show CropGridOverlay;
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:path_provider/path_provider.dart';

typedef PhotoUploadCallback = Future<void> Function(File croppedFile);

class CommonPhotoPreviewScreen extends StatefulWidget {
  const CommonPhotoPreviewScreen({
    super.key,
    required this.imageFile,
    required this.isUploading,
    required this.onUpload,
    this.title = AppStrings.cropPhoto,
    this.onClose,
  });

  final File imageFile;
  final RxBool isUploading;
  final PhotoUploadCallback onUpload;
  final String title;
  final VoidCallback? onClose;

  @override
  State<CommonPhotoPreviewScreen> createState() =>
      _CommonPhotoPreviewScreenState();
}

class _CommonPhotoPreviewScreenState extends State<CommonPhotoPreviewScreen> {
  final GlobalKey _cropKey = GlobalKey();

  Offset _offset = Offset.zero;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    if (widget.imageFile.path.isEmpty) {
      return const Scaffold(
        body: Center(child: Text(AppStrings.imageNotFound)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding + 20.verticalPadding,
        child: Obx(() {
          if (widget.isUploading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }

          return AppButton(
            name: AppStrings.upload,
            isEnable: true,
            onTop: _handleUpload,
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
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.onClose ?? Get.back,
                  ),
                ),
                CommonText.text(widget.title, fontWeight: FontWeight.w400),
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
                              _scale = 1.0;
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
                                borderRadius: BorderRadius.circular(20.r),
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

  Future<void> _handleUpload() async {
    final croppedFile = await _cropImage();
    await widget.onUpload(croppedFile);
  }

  Future<File> _cropImage() async {
    final context = _cropKey.currentContext;
    if (context == null) {
      throw Exception(AppStrings.cropAreaNotReady);
    }

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      throw Exception(AppStrings.cropBoundaryNotFound);
    }

    final image = await renderObject.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception(AppStrings.failedToCropImage);
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
