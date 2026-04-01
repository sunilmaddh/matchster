import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/photo_card.dart';
import 'package:matchster/features/common/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class AddPhotoWidget extends StatelessWidget {
  AddPhotoWidget({super.key});

  final OnboardController _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.displaySmall(
                AppStrings.addPhotoTitle,
                maxLines: 2,
                fontWeight: FontWeight.w600,
              ),
              CommonText.labelLarge(
                AppStrings.addPhotoDescription,
                maxLines: 3,
                fontWeight: FontWeight.w400,
              ),
              25.hBox,
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controller.fileList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    final image = _controller.fileList[index];

                    return InkWell(
                      onTap: () {
                        _controller.selectedImageIndex.value = index;
                        _showPhotoPickerBottomSheet(index: index);
                      },
                      child: PhotoCard(
                        image: image,
                        onDelete: () {
                          // _controller.removeFile(index);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Obx(
            () =>
                _controller.isSelectingImage.isTrue
                    ? Align(
                      alignment: Alignment.center,
                      child: LoadingIndicator(
                        colors: [AppColors.primary],
                        indicatorType: Indicator.lineSpinFadeLoader,
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _showPhotoPickerBottomSheet({required int index}) {
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
                        onTap: () async {
                          await _handlePhotoOptionTap(
                            optionText: option['text'],
                            index: index,
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(option['image']),
                            CommonText.labelLarge(
                              option['text'],
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
              child: CommonText.headlineSmall(AppStrings.cancel),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePhotoOptionTap({
    required String optionText,
    required int index,
  }) async {
    try {
      _closeBottomSheet();
      await Future.delayed(const Duration(milliseconds: 300));
      _clearImageCache();

      File? selectedImage;

      if (optionText == AppStrings.camera) {
        selectedImage = await _controller.imageService.getImageFromCamera();
      } else {
        selectedImage = await _controller.imageService.getImageFromGallery();
      }

      if (selectedImage == null || selectedImage.path.isEmpty) {
        return;
      }

      _controller.isSelectingImage(true);

      AppNavigation.to(
        AppRoutes.onboardPhotoPreviewView,
        arguments: {
          AppStrings.imageKey: selectedImage,
          AppStrings.indexKey: index,
          AppStrings.pageKey: AppStrings.onboardPage,
        },
      );
    } catch (error, stackTrace) {
      AppMethods.appPrint(message: error.toString());
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _controller.isSelectingImage(false);
    }
  }

  void _closeBottomSheet() {
    final context = Get.context;
    if (context != null &&
        Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _clearImageCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }
}
