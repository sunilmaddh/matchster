import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final formController = Get.find<ProfileFormController>();

    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.hBox,
          CommonText.titleMedium(AppStrings.makeItShortAndFunky),
          5.hBox,

          /// TEXT FIELD
          Container(
            height: 90.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightBlackBorder),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: 10.horizontalPadding + 5.verticalPadding,
              child: TextFormField(
                controller: formController.aboutController,
                decoration: InputDecoration(
                  hint: CommonText.bodyMedium(
                    AppStrings.aboutHint,
                    fontWeight: FontWeight.w300,
                    color: AppColors.aboutHintColor,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (about) {
                  formController.isAboutEnable.value = about.trim().isNotEmpty;
                },
              ),
            ),
          ),

          /// SAVE BUTTON
          Obx(
            () =>
                formController.isAboutEnable.isTrue
                    ? Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: AppButton(
                        isEnable: true,
                        name: AppStrings.save,
                        onTop: () {
                          controller.addAbout(
                            formController.aboutController.text.trim(),
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
