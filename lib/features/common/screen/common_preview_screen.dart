import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

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

  final _onboardController = Get.find<OnboardController>();

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
            name: "Crop & Upload",
            isEnable: true,
            onTop: () async {
              _onboardController.isImageUploading(true);
              final file = await _cropImage();
              if (file != null) {
                // _onboardController.validateAndUploadPhoto(
                //   file: file,
                //   index: widget.,
                // );
              } else {
                _onboardController.isImageUploading(false);
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
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.onClose ?? Get.back,
                  ),
                ),
                CommonText.text(widget.title, fontWeight: FontWeight.w400),
              ],
            ),

            /// 🔥 Image Preview
            Expanded(
              child: Center(
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
