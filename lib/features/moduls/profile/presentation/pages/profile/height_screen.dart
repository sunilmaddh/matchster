import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/bottomsheet/common_bottom_sheet.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/widgets/toggle_button_widget.dart';

class HeightScreen extends StatelessWidget {
  HeightScreen({super.key});

  final _controller = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        icon: Icons.check,
        isEnable: true,
        onTap: () {},
      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.text(
                  "Enter your Height",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                ToggleWithText(
                  onTop: () {
                    if (_controller.isNotFeet.isTrue) {
                      _controller.isNotFeet.value = false;
                    } else {
                      _controller.isNotFeet.value = true;
                    }
                  },
                  isFeet: _controller.isNotFeet,
                ),
              ],
            ),

            20.hBox,
            InkWell(
              onTap: () {
                CommonBottomSheet.showFullWidthCupertinoPicker(
                  isNotFeet: _controller.isNotFeet,
                  context: context,

                  listInch:
                      _controller.isNotFeet.isTrue
                          ? OnboardHalper.heightListCmDecimal
                          : OnboardHalper.heightListInch,

                  listFeet:
                      _controller.isNotFeet.isTrue
                          ? OnboardHalper.heightListCm
                          : OnboardHalper.heightListFeet,
                  onSelected: (String feet, String inch) {
                    _controller.heightController.text = feet;
                  },
                  defaultFeet: '',
                  defaultInch: '',
                );
              },
              child: CustomFormField(
                enable: false,
                label: "",
                hint: AppConstants.hintHeight,
                controller: _controller.heightController,
              ),
            ),
            10.hBox,
            Obx(
              () => RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Caros",
                  ),
                  text: "Note: ",
                  children: [
                    TextSpan(
                      text: AppConstants.heightNote1,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Caros",
                      ),
                    ),
                    TextSpan(
                      text:
                          _controller.isNotFeet.isTrue
                              ? AppConstants.heightNote2
                              : AppConstants.heightNote5,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Caros",
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: AppConstants.heightNote3,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Caros",
                      ),
                    ),
                    TextSpan(
                      text:
                          _controller.isNotFeet.isTrue
                              ? AppConstants.heightNote4
                              : AppConstants.heightNote6,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Caros",
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
