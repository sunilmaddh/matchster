import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/common/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/common/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/profile/controller/location_controller.dart';
import 'package:matchster/features/profile/helper/profile_helper.dart';

class AddHomeTownScreen extends BaseView<LocationController> {
  const AddHomeTownScreen({super.key});

  @override
  State<AddHomeTownScreen> createState() => _AddHomeTownScreenState();
}

class _AddHomeTownScreenState
    extends BaseViewState<LocationController, AddHomeTownScreen> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => CircleButtonWidget(
          icon: Icons.check,
          isEnable: controller.isSubmitEnabled.value,
          onTap: controller.submitHomeTown,
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.hometown,
        onTop: Get.back,
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hBox,
            CommonText.headlineMedium(
              AppStrings.whereAreYouFrom,
              fontWeight: FontWeight.w500,
            ),
            20.hBox,
            CommonText.text(AppStrings.city),
            10.hBox,
            CustomFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
              ],
              label: '',
              hint: AppStrings.enterYourCityName,
              controller: controller.cityController,
              enableBorder: controller.isSubmitEnabled,
              onChanged: (value) => controller.onCityChanged(value ?? ''),
            ),
            20.hBox,
            CommonText.text(AppStrings.state),
            10.hBox,
            InkWell(
              onTap: () => _showStateBottomSheet(context),
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
                          controller.selectedState.value.isNotEmpty
                              ? AppColors.textFieldColor
                              : AppColors.blackColor.withAlpha(64),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.text(
                        controller.selectedState.value.isNotEmpty
                            ? controller.selectedState.value
                            : AppStrings.selectYourState,
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            20.hBox,
            Obx(
              () =>
                  controller.selectedState.value.isNotEmpty
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.text(AppStrings.country),
                          10.hBox,
                          Container(
                            padding: 15.horizontalPadding,
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                width: 2,
                                color: AppColors.textFieldColor,
                              ),
                            ),
                            child: CommonText.text(
                              controller.selectedCountry.value,
                            ),
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showStateBottomSheet(BuildContext context) async {
    await CustomBottomSheet.show(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children:
                ProfileHelper.indianStates.map((state) {
                  return InkWell(
                    onTap: () {
                      controller.onStateSelected(state);
                      Get.back();
                    },
                    child: Container(
                      padding: 15.horizontalPadding + 10.verticalPadding,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border(
                          bottom: BorderSide(color: AppColors.commonLightColor),
                        ),
                      ),
                      child: CommonText.text(state),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
