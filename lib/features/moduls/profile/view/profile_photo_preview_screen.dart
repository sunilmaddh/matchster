import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';

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

  const ProfilePhotoPreviewScreen({
    super.key,
    required this.imageFile,
    required int imageIndex,
  });

  @override
  State<ProfilePhotoPreviewScreen> createState() =>
      _ProfilePhotoPreviewScreenState();
}

class _ProfilePhotoPreviewScreenState extends State<ProfilePhotoPreviewScreen> {
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: 15.horizontalPadding + 20.verticalPadding,
        child: Obx(() {
          if (_profileController.isImageUploading.isTrue) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          return AppButton(
            name: "Crop & Upload",
            isEnable: true,
            onTop: () async {
              try {
                _profileController.isImageUploading.value = true;
                final file = await _cropImage();
                if (file != null) {
                  _profileController.validateAndUploadPhoto(file: file);
                } else {
                  _profileController.isImageUploading.value = false;
                }
              } catch (e) {
                debugPrint(e.toString());
                _profileController.isImageUploading.value = false;
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

            /// 🔥 Image Preview
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.file(
                      widget.imageFile,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.black,
          backgroundColor: Colors.white,
          activeControlsWidgetColor: Colors.blue,
          cropGridColor: Colors.white.withOpacity(0.7),
          cropFrameColor: Colors.blue,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          lockAspectRatio: true,
          hideBottomControls: true,
          showCropGrid: true,
        ),
        IOSUiSettings(
          title: 'Crop Photo',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
