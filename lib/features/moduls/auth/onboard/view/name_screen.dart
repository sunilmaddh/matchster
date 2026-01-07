import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';

class NameWidget extends StatelessWidget {
  NameWidget({super.key});

  final _onboardController = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 10.hBox,
          CommonText.text(
            AppConstants.whatYourname,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),
          10.hBox,
          CustomFormField(
            label: "",
            hint: "Enter first name",
            controller: _onboardController.nameController,
            onChanged: (name) {
              if (name != null && name.isNotEmpty) {
                _onboardController.isEnable.value = true;
              }
            },
          ),
          10.hBox,
          Obx(
            () =>
                _onboardController.isEnable.isTrue
                    ? RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Caros",
                        ),
                        text: "${AppConstants.nameDiscription} ",
                        children: [
                          TextSpan(
                            text: AppConstants.nameDisSpan,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Caros",
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
