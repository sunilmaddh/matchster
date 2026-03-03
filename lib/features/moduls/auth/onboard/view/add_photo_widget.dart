import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/onboard/widgets/photo_card.dart';
import 'package:matchster/features/moduls/auth/onboard/view/photo_preview_screen.dart';

class AddPhotoWidget extends StatelessWidget {
  AddPhotoWidget({super.key});
  final _controller = Get.find<OnboardController>();

  void _showDeleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          'Delete Photo?',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Do you want to delete this photo?',
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
              'Cancel',
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
            child: Text('Delete'),
          ),
        ],
      ),
      barrierDismissible: false,
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
                "Show off your best photos!",
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
              // 10.hBox,
              CommonText.text(
                maxLines: 3,
                "Upload 5-6 favorite photos to let your personality shine. Make sure your uploads are clear and capture the real you!",
                fontSize: 14.sp,
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

                        CustomBottomSheet.show(
                          borderRadius: 40.r,
                          backgroundColor: const Color(0xffF4F4F4),
                          padding: EdgeInsets.zero,
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      15.horizontalPadding + 30.verticalPadding,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children:
                                        OnboardHalper.addPhotoOption.map((v) {
                                          return InkWell(
                                            onTap: () async {
                                              try {
                                                // 1️⃣ Prevent double tap
                                                // if (_controller
                                                //     .isSelectingImage
                                                //     .isTrue)
                                                //   return;

                                                // ❌ DO NOT set loader yet (this causes first-photo crash on Vivo)

                                                // 2️⃣ Force close bottom sheet / overlay
                                                final context = Get.context;
                                                if (context != null &&
                                                    Navigator.of(
                                                      context,
                                                      rootNavigator: true,
                                                    ).canPop()) {
                                                  Navigator.of(
                                                    context,
                                                    rootNavigator: true,
                                                  ).pop();
                                                }

                                                // 3️⃣ Give Vivo camera time to get foreground (CRITICAL)
                                                await Future.delayed(
                                                  const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                );

                                                // 4️⃣ Clear image cache BEFORE opening camera
                                                PaintingBinding
                                                    .instance
                                                    .imageCache
                                                    .clear();
                                                PaintingBinding
                                                    .instance
                                                    .imageCache
                                                    .clearLiveImages();

                                                File? selectedImage;

                                                // 5️⃣ Open camera/gallery WITHOUT touching UI state
                                                if (v["text"] == "Camera") {
                                                  selectedImage =
                                                      await ImageUploadServices()
                                                          .pickImageFromCamera();
                                                } else {
                                                  selectedImage =
                                                      await ImageUploadServices()
                                                          .getImageFromGallery();
                                                }

                                                // 6️⃣ NOW update UI
                                                debugPrint(
                                                  "Selected image ${selectedImage.toString()}",
                                                );
                                                if (selectedImage != null &&
                                                    selectedImage
                                                        .path
                                                        .isNotEmpty) {
                                                  _controller.isSelectingImage(
                                                    true,
                                                  ); // loader AFTER camera

                                                  Get.to(
                                                    () => PhotoPreviewScreen(
                                                      imageFile: selectedImage!,
                                                      index: index,
                                                      page: 'onboard',
                                                    ),
                                                  )!.whenComplete(() {
                                                    _controller
                                                        .isSelectingImage(
                                                          false,
                                                        );
                                                  });
                                                }
                                              } catch (e, s) {
                                                AppMethods.appPrint(
                                                  message: e.toString(),
                                                );
                                                debugPrintStack(stackTrace: s);
                                              }
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
                                  onPressed: Get.back,
                                  child: CommonText.text(
                                    "Cancel",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: PhotoCard(
                        image: image,
                        onDelete: () => _showDeleteDialog(index),
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
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
