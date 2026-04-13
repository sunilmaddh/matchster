import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/app_input_formetters.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';

class NameWidget extends StatelessWidget {
  NameWidget({super.key});
  final _onboardController = Get.find<OnboardController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 10.hBox,
          CommonText.displaySmall(
            AppConstants.whatYourname,

            fontWeight: FontWeight.w600,
          ),
          15.hBox,
          Form(
            key: _formKey,
            child: CustomFormField(
              maxLength: 15,
              inputFormatters: [
                AppInputFormatters.onlyCharacters(),
                AppInputFormatters.firstLetterCapital(),
              ],
              enableBorder: _onboardController.isEnable,
              label: AppStrings.enterYourNameLabel,
              hint: AppStrings.enterYourNameHint,
              controller: _onboardController.nameController,
              validator: (name) {
                return AppMethods.validateText(name);
              },
              onChanged: (name) {
                if (name != null && name.isNotEmpty) {
                  if (_formKey.currentState!.validate()) {
                    _onboardController.isNameValid.value = true;
                  } else {
                    _onboardController.isNameValid.value = false;
                  }
                } else {
                  _onboardController.isNameValid.value = false;
                }

                _onboardController.updateButtonState();
              },
            ),
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
