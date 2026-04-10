import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_location_controller.dart';

// ignore: must_be_immutable
class AddHomeTownScreen extends BaseView<ProfileLocationController> {
  AddHomeTownScreen({super.key});

  @override
  void onInit(ProfileLocationController controller) {
    final String city = Get.arguments["city"] ?? "";
    final String state = Get.arguments["state"] ?? "";
    final String country = Get.arguments["country"] ?? "";
    final String countryCode = Get.arguments["country_code"] ?? "";
    final String stateCode = Get.arguments["state_code"] ?? "";
    controller.setLocationData(
      state: state,
      country: country,
      city: city,
      countryCode: countryCode,
      stateCode: stateCode,
    );
    controller.getCountry();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => CircleButtonWidget(
          icon: Icons.check,
          isEnable: controller.isEnable.value,
          onTap: () {
            controller.addHomeLocation(
              city: controller.selectedCity.value,
              state: controller.selectedState.value,
              country: controller.selectedCountry.value,
              countryCode: controller.selectedCountryCode.value,
              stateCode: controller.selectedStateCode.value,
            );
          },
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.locationString.hometown,
        onTop: Get.back,
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hBox,
            CommonText.text(
              AppStrings.locationString.whereAreYouFrom,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),

            /// Country
            20.hBox,
            CommonText.text(AppStrings.locationString.country),
            10.hBox,
            InkWell(
              onTap: controller.onCountryTap,
              child: Obx(
                () => _buildBox(
                  text:
                      controller.selectedCountry.value.isNotEmpty
                          ? controller.selectedCountry.value
                          : AppStrings.locationString.selectCountry,
                  isSelected: controller.selectedCountry.value.isNotEmpty,
                ),
              ),
            ),

            /// State
            20.hBox,
            CommonText.text(AppStrings.locationString.state),
            10.hBox,
            InkWell(
              onTap: controller.onStateTap,
              child: Obx(
                () => _buildBox(
                  text:
                      controller.selectedState.value.isNotEmpty
                          ? controller.selectedState.value
                          : AppStrings.locationString.selectState,
                  isSelected: controller.selectedState.value.isNotEmpty,
                ),
              ),
            ),

            /// City
            20.hBox,
            CommonText.text(AppStrings.locationString.city),
            10.hBox,
            InkWell(
              onTap: controller.onCityTap,
              child: Obx(
                () => _buildBox(
                  text:
                      controller.selectedCity.value.isNotEmpty
                          ? controller.selectedCity.value
                          : AppStrings.locationString.selectCityTitle,
                  isSelected: controller.selectedCity.value.isNotEmpty,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox({required String text, required bool isSelected}) {
    return Container(
      padding: 15.horizontalPadding,
      height: 48.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 2,
          color:
              isSelected
                  ? AppColors.textFieldColor
                  : AppColors.blackColor.withAlpha(64),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.text(text),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
