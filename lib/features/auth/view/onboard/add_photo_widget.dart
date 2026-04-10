import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controller/onboard_photo_controller.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';
import 'package:matchster/features/auth/view/onboard/photo_preview_screen.dart';
import 'package:matchster/features/auth/widgets/photo_card.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class AddPhotoWidget extends StatelessWidget {
  AddPhotoWidget({super.key});

  final OnboardPhotoController _controller = Get.find<OnboardPhotoController>();

  void _showDeleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          AppStrings.deletePhotoTitle,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          AppStrings.deletePhotoMessage,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: Get.back,
            child: Text(
              AppStrings.cancel,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              _controller.removeFile(index);
              Get.back();
            },
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _handlePhotoOptionTap({
    required Map<String, dynamic> option,
    required int index,
  }) async {
    try {
      final context = Get.context;
      if (context != null &&
          Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      await Future.delayed(const Duration(milliseconds: 300));

      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      File? selectedImage;

      if (option["text"] == AppStrings.camera) {
        selectedImage = await ImageUploadServices().pickImageFromCamera();

        if (selectedImage != null && selectedImage.path.isNotEmpty) {
          Get.to(
            () => PhotoPreviewScreen(imageFile: selectedImage!, index: index),
          );
        }
      } else {
        final selectedImages =
            await ImageUploadServices().pickImagesFromGallery();

        if (selectedImages != null && selectedImages.isNotEmpty) {
          final filledCount =
              _controller.fileList.where((file) => file.isNotEmpty).length;

          final remaining = 6 - filledCount;

          final selectedFile = selectedImages.take(remaining).toList();

          await _controller.addSelectedFiles(selectedFile);
        }
      }
    } catch (e, s) {
      AppMethods.appPrint(message: e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  void _showPhotoOptions({required int index}) {
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
                    OnboardHalper.addPhotoOption.map((option) {
                      return InkWell(
                        onTap:
                            () => _handlePhotoOptionTap(
                              option: option,
                              index: index,
                            ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(option["image"]),
                            CommonText.text(
                              option["text"],
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
              onPressed: Get.back,
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

  Widget _buildPhotoItem({required String image, required int index}) {
    return InkWell(
      key: ValueKey(image.isNotEmpty ? 'drag_$index' : 'empty_$index'),
      onTap: () => _showPhotoOptions(index: index),
      child: PhotoCard(
        image: image,
        onDelete: index == 0 ? null : () => _showDeleteDialog(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.text(
                maxLines: 2,
                AppStrings.showOffBestPhotos,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
              CommonText.text(
                maxLines: 3,
                AppStrings.uploadFavoritePhotosDescription,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              25.hBox,
              Obx(
                () => ReorderableGridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controller.fileList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 1.2,
                  ),
                  onReorder: (oldIndex, newIndex) {
                    if (_controller.fileList[oldIndex].isNotEmpty &&
                        _controller.fileList[newIndex].isNotEmpty) {
                      final item = _controller.fileList.removeAt(oldIndex);
                      _controller.fileList.insert(newIndex, item);
                    }
                  },
                  itemBuilder: (context, index) {
                    final image = _controller.fileList[index];
                    return _buildPhotoItem(image: image, index: index);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
