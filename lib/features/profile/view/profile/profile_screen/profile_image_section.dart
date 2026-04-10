import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/login_widgets/login_button.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/view/profile_photo_preview_screen.dart';
import 'package:matchster/features/profile/widgets/add_image_grid_widget.dart';
import 'package:matchster/routes/app_navigation.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return AddImageGrid(
      imageList: controller.allPfFame,
      onTop: (index) {
        _showAddPhotoBottomSheet(context, controller, index);
      },
      onTopRemove: (id) {
        _showRemovePhotoBottomSheet(context, controller, id);
      },
      onSwap: (position1, position2) {
        controller.swapFames(position1: position1, position2: position2);
      },
    );
  }

  void _showRemovePhotoBottomSheet(
    BuildContext context,
    ProfileController controller,
    String id,
  ) {
    CustomBottomSheet.show(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              isEnable: true,
              name: AppStrings.remove,
              onTop: () {
                controller.deleteProfile(profileId: id);
              },
            ),
            20.hBox,
            LoginButton(name: AppStrings.cancel, onTop: AppNavigation.back),
          ],
        ),
      ),
    );
  }

  void _showAddPhotoBottomSheet(
    BuildContext context,
    ProfileController controller,
    int index,
  ) {
    if (controller.allPfFame.length >= 6) {
      AppToastMessage.show(
        title: AppStrings.limitReached,
        message: AppStrings.maxPhotoLimit,
        isError: true,
      );
      return;
    }

    CustomBottomSheet.show(
      borderRadius: 40.r,
      backgroundColor: const Color(0xffF4F4F4),
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
                    OnboardHalper.addPhotoOption.map((v) {
                      return InkWell(
                        onTap: () async {
                          await _handlePhotoSelection(
                            controller: controller,
                            optionText: v["text"],
                            index: index,
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(v["image"]),
                            CommonText.text(
                              v["text"],
                              fontSize: 14.sp,
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
              onPressed: AppNavigation.back,
              child: CommonText.text(
                AppStrings.cancel,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePhotoSelection({
    required ProfileController controller,
    required String optionText,
    required int index,
  }) async {
    try {
      AppNavigation.back();

      File? selectedImage;

      if (optionText == AppStrings.camera) {
        selectedImage = await ImageUploadServices().pickImageFromCamera();
      } else {
        final files = await ImageUploadServices().pickImagesFromGallery();
        if (files != null && files.isNotEmpty) {
          final remaining = 6 - controller.allPfFame.length;
          final selectedFiles = files.take(remaining).toList();
          await controller.processSelectedFiles(selectedFiles);
        }
      }

      if (selectedImage != null && selectedImage.path.isNotEmpty) {
        await Get.to(
          () => ProfilePhotoPreviewScreen(
            imageFile: selectedImage!,
            imageIndex: index,
          ),
        );
      }
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
    }
  }
}
