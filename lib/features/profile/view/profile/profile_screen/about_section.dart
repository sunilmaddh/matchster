import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.hBox,
          CommonText.titleMedium(AppStrings.makeItShortAndFunky),
          5.hBox,
          Container(
            height: 90.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withAlpha(51)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: 10.horizontalPadding + 5.verticalPadding,
              child: TextFormField(
                controller: controller.aboutController,
                decoration: InputDecoration(
                  hint: CommonText.text(
                    AppStrings.aboutHint,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff898A8D),
                  ),
                  border: InputBorder.none,
                ),
                showCursor: false,
                onChanged: (about) {
                  controller.isAboutEnable.value = about.trim().isNotEmpty;
                },
              ),
            ),
          ),
          Obx(
            () =>
                controller.isAboutEnable.isTrue
                    ? Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: AppButton(
                        isEnable: true,
                        name: AppStrings.save,
                        onTop: () {
                          controller.addAout(
                            about: controller.aboutController.text,
                          );
                        },
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
