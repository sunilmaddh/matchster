import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/bottomsheet/common_bottom_sheet.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';

class HeightScreen extends StatelessWidget {
  HeightScreen({super.key});

  final _controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: CircleButtonWidget(
      //   icon: Icons.check,
      //   isEnable: true,
      //   onTap: () {

      //   },
      // ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Height",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hBox,

            CommonText.text(
              "What is your height?",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Caros",
            ),
            10.hBox,
            CommonText.text(
              maxLines: 2,
              "Share your height to help others to get to know you better",
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Caros",
            ),
            20.hBox,
            InkWell(
              onTap: () {
                CommonBottomSheet.showHeightPicker(
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
                    print(
                      "${height.feet}'${height.inch}\" = ${height.cm.toStringAsFixed(2)} cm",
                    );
                    // _controller.feet.value = height.feet;
                    print(
                      "${height.feet}'${height.inch}\" = ${height.cm.toStringAsFixed(2)} cm",
                    );
                  },
                  onTap: () {
                    _controller.addHeight();
                  },
                  isEnable: true.obs,
                );
                AppMethods.hideKeyboard();
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
            ),
          ],
        ),
      ),
    );
  }
}
