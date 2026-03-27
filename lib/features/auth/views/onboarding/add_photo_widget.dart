import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/photo_card.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class AddPhotoWidget extends StatelessWidget {
  AddPhotoWidget({super.key});
  final _controller = Get.find<OnboardController>();

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

                                                await Future.delayed(
                                                  const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                );

                                                PaintingBinding
                                                    .instance
                                                    .imageCache
                                                    .clear();
                                                PaintingBinding
                                                    .instance
                                                    .imageCache
                                                    .clearLiveImages();

                                                File? selectedImage;

                                                if (v["text"] == "Camera") {
                                                  selectedImage =
                                                      await _controller
                                                          .imageService
                                                          .getImageFromCamera();
                                                } else {
                                                  selectedImage =
                                                      await _controller
                                                          .imageService
                                                          .getImageFromGallery();
                                                }
                                                if (selectedImage == null ||
                                                    selectedImage
                                                        .path
                                                        .isEmpty) {
                                                  return;
                                                }

                                                _controller.isSelectingImage(
                                                  true,
                                                );

                                                AppNavigation.to(
                                                  AppRoutes
                                                      .profilePreviewScreen,
                                                  arguments: {
                                                    "image": selectedImage,
                                                    "index": index,
                                                    "page": "onboard",
                                                  },
                                                );
                                              } catch (e, s) {
                                                AppMethods.appPrint(
                                                  message: e.toString(),
                                                );
                                                debugPrintStack(stackTrace: s);
                                              } finally {
                                                _controller.isSelectingImage(
                                                  false,
                                                );
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
                                Divider(height: 1),
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
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
