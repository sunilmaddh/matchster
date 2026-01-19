import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/services/image_upload_services.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Stack(
        children: [
          Obx(
            () =>
                _controller.isSelectingImage.isTrue
                    ? Container(
                      width: Get.width,
                      color: Colors.grey,
                      height: Get.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    )
                    : SizedBox.shrink(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.text(
                maxLines: 2,
                "Show off your best photos and videos!",
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
              // 10.hBox,
              CommonText.text(
                maxLines: 3,
                "Upload 5-6 favorite photos or a video to let your personality shine. Make sure your uploads are clear and capture the real you!",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              20.hBox,
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controller.fileList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
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
                                              File? selectedImage;

                                              if (v["text"] == "Camera") {
                                                selectedImage =
                                                    await ImageUploadServices()
                                                        .getImageFromCamera();
                                              } else {
                                                selectedImage =
                                                    await ImageUploadServices()
                                                        .getImageFromGallery();
                                              }
                                              Get.back();
                                              _controller.isSelectingImage(
                                                true,
                                              );
                                              await Future.delayed(
                                                const Duration(
                                                  milliseconds: 150,
                                                ),
                                              );

                                              if (selectedImage != null) {
                                                Get.to(
                                                  () => PhotoPreviewScreen(
                                                    imageFile: selectedImage!,
                                                    index: index,
                                                  ),
                                                );
                                              }
                                              _controller.isSelectingImage(
                                                false,
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
        ],
      ),
    );
  }
}
