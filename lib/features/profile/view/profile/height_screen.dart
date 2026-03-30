import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/bottomsheet/common_bottom_sheet.dart';
import 'package:matchster/features/common/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/helpers/onboard_halper.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';

class HeightScreen extends StatelessWidget {
  HeightScreen({super.key});

  final ProfileController _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        icon: Icons.check,
        isEnable: true,
        onTap: () {
          _controller.addHeight(
            feet: _controller.feet.value,
            cm: _controller.cm.value,
          );
        },
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.height,
        onTop: Get.back,
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hBox,
            CommonText.headlineMedium(
              AppStrings.whatIsYourHeight,

              fontWeight: FontWeight.w500,
            ),
            10.hBox,
            CommonText.titleMedium(
              AppStrings.heightDescription,
              maxLines: 2,

              fontWeight: FontWeight.w400,
            ),
            20.hBox,
            InkWell(
              onTap: () {
                final heightList = OnboardHalper().generateHeightList();

                CommonBottomSheet.showHeightPicker(
                  context: context,
                  heightList: heightList,
                  defaultValue: heightList.first,
                  onSelected: (height) {
                    _controller.feet.value = double.parse(
                      '${height.feet}.${height.inch}',
                    );
                    _controller.cm.value = height.cm;
                    _controller.height.value =
                        "${height.feet} ${AppStrings.feet}, ${height.inch} ${AppStrings.inch}";
                  },
                  onTap: () {
                    _controller.addHeight(
                      feet: _controller.feet.value,
                      cm: _controller.cm.value,
                    );
                  },
                  isEnable: true.obs,
                );

                AppMethods.hideKeyboard();
              },
              child: Obx(
                () => Container(
                  padding: 15.horizontalPadding,
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
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
                  child: CommonText.titleLarge(
                    _controller.height.value.isNotEmpty
                        ? _controller.height.value
                        : AppStrings.selectYourHeight,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    color:
                        _controller.height.value.isNotEmpty
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
