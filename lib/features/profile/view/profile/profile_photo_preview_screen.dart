import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/photo_review_bottomsheet.dart';
import 'package:matchster/features/common/screen/common_preview_screen.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfilePhotoPreviewScreen extends BaseView<ProfileController> {
  const ProfilePhotoPreviewScreen({super.key});

  @override
  bool get useDefaultLoader => false;

  @override
  State<ProfilePhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState
    extends BaseViewState<ProfileController, ProfilePhotoPreviewScreen> {
  late final OnboardController _onboardController;

  late final File _imageFile;
  late final int _index;
  late final String _page;

  @override
  void onInit() {
    super.onInit();

    _onboardController = Get.find<OnboardController>();

    final args = (Get.arguments as Map<String, dynamic>?) ?? {};
    final image = args['image'];

    _imageFile = image is File ? image : File('');
    _index = args['index'] is int ? args['index'] as int : 0;
    _page = args['page']?.toString() ?? '';
  }

  @override
  Widget buildView(BuildContext context) {
    return CommonPhotoPreviewScreen(
      imageFile: _imageFile,
      isUploading: _onboardController.isImageUploading,
      title: AppStrings.cropPhoto,
      onUpload: (croppedFile) async {
        try {
          await _onboardController.validateAndUploadPhoto(
            file: croppedFile,
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
            title: AppStrings.error,
            message: e.toString(),
            isError: true,
          );
        }
      },
    );
  }
}
