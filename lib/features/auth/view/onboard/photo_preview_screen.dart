import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controller/onboard_photo_controller.dart';

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

class PhotoPreviewScreen extends BaseView<OnboardPhotoController> {
  const PhotoPreviewScreen({
    super.key,
    required this.imageFile,
    required this.index,
  });

  final File imageFile;
  final int index;

  @override
  bool get useDefaultLoader => false;

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState
    extends BaseViewState<OnboardPhotoController, PhotoPreviewScreen> {
  @override
  void onInit() {
    controller.setPreviewData(file: widget.imageFile, index: widget.index);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding + 20.verticalPadding,
        child: Obx(() {
          if (controller.isImageUploading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return AppButton(
            name: 'Crop & Upload',
            isEnable: true,
            onTop: controller.onCropAndUploadTap,
          );
        }),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), _buildImagePreview()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: controller.navigateBack,
            ),
          ),
        ),
        CommonText.text('Crop photo', fontWeight: FontWeight.w400),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Obx(() {
              final previewFile =
                  controller.previewImage.value ?? widget.imageFile;

              return Image.file(
                previewFile,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              );
            }),
          ),
        ),
      ),
    );
  }
}
