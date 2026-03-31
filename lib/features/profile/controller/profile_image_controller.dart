import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/features/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/login_widget/login_button.dart';
import 'package:matchster/features/common/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileImageController extends BaseController {
  ProfileImageController({required this.profileController});

  final ProfileController profileController;

  List<dynamic> get hallOfFames => profileController.hallOfFames;

  Future<void> showImagePickerSheet() async {
    if (hallOfFames.length >= 6) {
      AppToastMessage.show(
        title: AppStrings.limitReached,
        message: AppStrings.maxPhotoUploadMessage,
        isError: true,
      );
      return;
    }

    await CustomBottomSheet.show(
      borderRadius: 40.r,
      backgroundColor: AppColors.sheetBackground,
      padding: EdgeInsets.zero,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: 15.horizontalPadding + 30.verticalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    OnboardHalper.addPhotoOption.map((option) {
                      return InkWell(
                        onTap: () => pickImage(option["text"] ?? ''),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(option["image"] ?? ''),
                            CommonText.labelLarge(
                              option["text"] ?? '',
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
            const Divider(height: 1),
            10.hBox,
            TextButton(
              onPressed: Get.back,
              child: CommonText.headlineSmall(
                AppStrings.cancel,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(String source) async {
    try {
      final context = Get.context;
      if (context != null &&
          Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      if (source == AppStrings.camera) {
        final selectedImage = await ImageUploadServices().pickImageFromCamera();

        if (selectedImage != null && selectedImage.path.isNotEmpty) {
          navigateTo(
            AppRoutes.profilePhotoPreviewScreen,
            arguments: selectedImage,
          );
        }
        return;
      }

      final files = await ImageUploadServices().pickImagesFromGallery();

      if (files != null && files.isNotEmpty) {
        final remaining = 6 - hallOfFames.length;
        final selectedFiles = files.take(remaining).toList();

        for (final file in selectedFiles) {
          navigateTo(AppRoutes.profilePhotoPreviewScreen, arguments: file);
        }
      }
    } catch (e, s) {
      AppMethods.appPrint(message: e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> showRemoveImageSheet(String id) async {
    await CustomBottomSheet.show(
      child: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              isEnable: true,
              name: AppStrings.remove,
              onTop: () {
                Get.back();
                profileController.deleteProfile(profileId: id);
              },
            ),
            20.hBox,
            LoginButton(name: AppStrings.cancel, onTop: Get.back),
          ],
        ),
      ),
    );
  }

  void swapProfileImages({required int position1, required int position2}) {
    profileController.swapFames(position1: position1, position2: position2);
  }
}
