import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/common_bottom_sheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';
import 'package:matchster/routes/app_navigation.dart';

class YourHeightWidget extends StatelessWidget {
  YourHeightWidget({super.key});

  final _controller = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.whatYourHeight,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),
          // 20.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.heightDescription,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),

          20.hBox,
          InkWell(
            onTap: () async {
              _controller.isBottomSheetOpen.value = true;
              await CommonBottomSheet.showHeightPicker(
                context: context,
                heightList: OnboardHalper().generateHeightList(),
                defaultValue: OnboardHalper().generateHeightList()[0],

                onSelected: (height) {
                  _controller.feet.value = double.parse(
                    '${height.feet}.${height.inch}',
                  );
                  _controller.cm.value = height.cm;
                  _controller.heightController.value =
                      "${height.feet} feet ${height.inch} inch";
                  _controller.isHeightSelected.value = true;
                  _controller.updateButtonState();
                  debugPrint(_controller.isHeightSelected.value.toString());
                },
                onTap: () async {
                  AppNavigation.back();
                  if (_controller.isButtonEnabled.value) {
                    _controller.isNextPageEnable.value = false;
                    final current = _controller.currentIndex.value;
                    await _controller.submitStep(current);

                    _controller.completeStep(current);
                  }
                  AppMethods.hideKeyboard();
                },
                isEnable: _controller.isButtonEnabled,
              );
              _controller.isBottomSheetOpen.value = false;
            },
            child: Obx(
              () => Container(
                padding: 15.horizontalPadding,
                alignment: Alignment.centerLeft,
                width: Get.width,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    width: 1.w,
                    color:
                        _controller.isEnable.value
                            ? AppColors.textFieldColor
                            : AppColors.blackColor.withAlpha(64),
                  ),
                ),
                child: CommonText.text(
                  _controller.heightController.isNotEmpty
                      ? _controller.heightController.value
                      : "Select your height",

                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.sp,
                  color:
                      _controller.heightController.isNotEmpty
                          ? AppColors.blackColor
                          : AppColors.blackColor.withAlpha(128),
                ),
              ),
            ),

            // CustomFormField(
            //   enable: false,
            //   label: "",
            //   hint: AppConstants.hintHeight,
            //   controller: _controller.heightController,
            //   enableBorder: true.obs,
            // ),
          ),
        ],
      ),
    );
  }
}
