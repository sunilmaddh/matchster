import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/modules/auth/helpers/onboard_halper.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/services/image_upload_services.dart';

class ImagePickerBottomSheet {
  static void show({required Function(File file) onImageSelected}) {
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
                      return _PickerOption(
                        image: option["image"],
                        text: option["text"],
                        onTap: () async {
                          File? selectedImage;

                          if (option["text"] == "Camera") {
                            selectedImage =
                                await ImageUploadServices()
                                    .getImageFromCamera();
                          } else {
                            selectedImage =
                                await ImageUploadServices()
                                    .getImageFromGallery();
                          }

                          if (selectedImage != null) {
                            onImageSelected(selectedImage);
                          }

                          // Get.back();
                        },
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
  }
}

class _PickerOption extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const _PickerOption({
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image),
          6.hBox,
          CommonText.text(text, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}
