import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/helper/profile_helper.dart';

class AddHomeTownScreen extends StatelessWidget {
  AddHomeTownScreen({super.key});

  final _controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => CircleButtonWidget(
          icon: Icons.check,
          isEnable: _controller.isEnable.value,
          onTap: () {
            _controller.addHomeLocation(
              city: _controller.cityController.text,
              state: _controller.selectedState.value,
              country: "India",
            );
          },
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Hometown",
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
              "Where are you from?",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Caros",
            ),

            20.hBox,
            CommonText.text("City"),
            10.hBox,
            CustomFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
              ],
              label: "",
              hint: "Enter your city name",
              controller: _controller.cityController,
              enableBorder: _controller.isEnable,
              onChanged: (v) {
                if (v != null && v.isNotEmpty) {
                  _controller.isEnable.value = true;
                  _controller.cityController.text = v;
                } else {
                  _controller.isEnable.value = false;
                }
              },
            ),

            20.hBox,
            CommonText.text("State"),
            10.hBox,
            InkWell(
              onTap: () async {
                await CustomBottomSheet.show(
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children:
                            ProfileHelper.indianStates.map((v) {
                              return InkWell(
                                onTap: () {
                                  _controller.selectedState.value = v;
                                  Get.back();
                                },
                                child: Container(
                                  padding:
                                      15.horizontalPadding + 10.verticalPadding,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.commonLightColor,
                                      ),
                                    ),
                                  ),
                                  child: CommonText.text(v),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                );
              },
              child: Obx(
                () => Container(
                  padding: 15.horizontalPadding,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      width: 2,
                      color:
                          _controller.selectedState.isNotEmpty
                              ? AppColors.textFieldColor
                              : AppColors.blackColor.withAlpha(64),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.text(
                        _controller.selectedState.value.isNotEmpty
                            ? _controller.selectedState.value
                            : "Select your state",
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            20.hBox,
            Obx(
              () =>
                  _controller.selectedState.isNotEmpty
                      ? CommonText.text("Country")
                      : SizedBox.shrink(),
            ),
            10.hBox,
            Obx(
              () =>
                  _controller.selectedState.isNotEmpty
                      ? Container(
                        padding: 15.horizontalPadding,
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 2,
                            color:
                                _controller.selectedState.isNotEmpty
                                    ? AppColors.textFieldColor
                                    : AppColors.blackColor.withAlpha(64),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText.text("India"),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: Icon(Icons.keyboard_arrow_down),
                            // ),
                          ],
                        ),
                      )
                      : SizedBox.shrink(),
            ),

            // CustomFormField(
            //   in
            //   label: "",
            //   hint: "Enter your  name",
            //   controller: _controller.companyController,
            //   enableBorder: false.obs,
            // ),
          ],
        ),
      ),
    );
  }
}
