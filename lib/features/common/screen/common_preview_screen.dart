import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/crop_grid_overlay.dart';
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

  final double _aspectRatio = 3 / 4;
  final double _borderRadius = 20;
  final double _minScale = 1.0;
  final double _maxScale = 4.0;

  Size? _originalImageSize;

  Offset _offset = Offset.zero;
  double _scale = 1.0;

  double _startScale = 1.0;
  Offset _startOffset = Offset.zero;
  Offset? _lastFocalPoint;

  @override
  void initState() {
    super.initState();
    _loadImageSize();
  }

  Future<void> _loadImageSize() async {
    final bytes = await widget.imageFile.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();

    if (!mounted) return;

    setState(() {
      _originalImageSize = Size(
        frame.image.width.toDouble(),
        frame.image.height.toDouble(),
      );
    });
  }

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
            Expanded(
              child: Center(
                child:
                    _originalImageSize == null
                        ? const CircularProgressIndicator()
                        : LayoutBuilder(
                          builder: (context, constraints) {
                            final cropWidth = constraints.maxWidth * 0.82;
                            final cropHeight = cropWidth / _aspectRatio;
                            final cropSize = Size(cropWidth, cropHeight);

                            final baseImageSize = _getBaseImageSize(
                              imageSize: _originalImageSize!,
                              cropSize: cropSize,
                            );

                            final safeOffset = _clampOffset(
                              offset: _offset,
                              cropSize: cropSize,
                              baseImageSize: baseImageSize,
                              scale: _scale,
                            );

                            if (safeOffset != _offset) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (!mounted) return;
                                setState(() {
                                  _offset = safeOffset;
                                });
                              });
                            }

                            final scaledWidth = baseImageSize.width * _scale;
                            final scaledHeight = baseImageSize.height * _scale;

                            final imageLeft =
                                (cropWidth - scaledWidth) / 2 + _offset.dx;
                            final imageTop =
                                (cropHeight - scaledHeight) / 2 + _offset.dy;

                            return SizedBox(
                              width: cropWidth,
                              height: cropHeight,
                              child: Stack(
                                children: [
                                  RepaintBoundary(
                                    key: _cropKey,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        _borderRadius.r,
                                      ),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onScaleStart: (details) {
                                          _startScale = _scale;
                                          _startOffset = _offset;
                                          _lastFocalPoint = details.focalPoint;
                                        },
                                        onScaleUpdate: (details) {
                                          if (_originalImageSize == null)
                                            return;

                                          final currentFocalPoint =
                                              details.focalPoint;
                                          final delta =
                                              _lastFocalPoint == null
                                                  ? Offset.zero
                                                  : currentFocalPoint -
                                                      _lastFocalPoint!;

                                          _lastFocalPoint = currentFocalPoint;

                                          if (details.pointerCount == 1) {
                                            final newOffset = _clampOffset(
                                              offset: _offset + delta,
                                              cropSize: cropSize,
                                              baseImageSize: baseImageSize,
                                              scale: _scale,
                                            );

                                            setState(() {
                                              _offset = newOffset;
                                            });
                                            return;
                                          }

                                          final newScale = (_startScale *
                                                  details.scale)
                                              .clamp(_minScale, _maxScale);

                                          final scaledBaseWidth =
                                              baseImageSize.width * newScale;
                                          final scaledBaseHeight =
                                              baseImageSize.height * newScale;

                                          final maxDx =
                                              (scaledBaseWidth -
                                                  cropSize.width) /
                                              2;
                                          final maxDy =
                                              (scaledBaseHeight -
                                                  cropSize.height) /
                                              2;

                                          final newOffset = Offset(
                                            (_startOffset.dx + delta.dx).clamp(
                                              -maxDx,
                                              maxDx,
                                            ),
                                            (_startOffset.dy + delta.dy).clamp(
                                              -maxDy,
                                              maxDy,
                                            ),
                                          );

                                          setState(() {
                                            _scale = newScale;
                                            _offset = _clampOffset(
                                              offset: newOffset,
                                              cropSize: cropSize,
                                              baseImageSize: baseImageSize,
                                              scale: newScale,
                                            );
                                          });
                                        },
                                        onScaleEnd: (_) {
                                          _lastFocalPoint = null;
                                        },
                                        child: Container(
                                          color: Colors.black,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: imageLeft,
                                                top: imageTop,
                                                child: SizedBox(
                                                  width: scaledWidth,
                                                  height: scaledHeight,
                                                  child: Image.file(
                                                    widget.imageFile,
                                                    fit: BoxFit.fill,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CropGridOverlay(
                                    borderRadius: _borderRadius.r,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Size _getBaseImageSize({required Size imageSize, required Size cropSize}) {
    final imageAspect = imageSize.width / imageSize.height;
    final cropAspect = cropSize.width / cropSize.height;

    double width;
    double height;

    if (imageAspect > cropAspect) {
      height = cropSize.height;
      width = height * imageAspect;
    } else {
      width = cropSize.width;
      height = width / imageAspect;
    }

    return Size(width, height);
  }

  Offset _clampOffset({
    required Offset offset,
    required Size cropSize,
    required Size baseImageSize,
    required double scale,
  }) {
    final scaledWidth = baseImageSize.width * scale;
    final scaledHeight = baseImageSize.height * scale;

    final maxDx = (scaledWidth - cropSize.width) / 2;
    final maxDy = (scaledHeight - cropSize.height) / 2;

    return Offset(
      offset.dx.clamp(-maxDx, maxDx),
      offset.dy.clamp(-maxDy, maxDy),
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
