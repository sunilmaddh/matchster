import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/card/switch_card.dart';
import 'package:matchster/features/common/widgets/fields/common_card.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/home/controller/filter_controller.dart';
import 'package:matchster/features/home/widgets/seek_bar_widget.dart';
import 'package:matchster/features/home/widgets/text_with_widget.dart';

class AgeWidget extends StatelessWidget {
  const AgeWidget({super.key, required this.controller});
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      isBorder: false,
      color: AppColors.filterCardColor,
      widget: Column(
        children: [
          TextWithWidget(
            title: AppStrings.ageTitle,
            subTitle: AppStrings.ageSubtitle,
            widget: Stack(
              children: [
                Flexible(child: AnimatedSeekBar(value: 50, onChanged: (v) {})),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5.h, right: 4.w),
                      height: 16.h,
                      width: 16.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.gradientBoxCircle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(38),
                            blurRadius: 6.r,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.5.r),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return AppColors.gradientBoxCircle.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        );
                      },
                      blendMode: BlendMode.srcIn,
                      child: CommonText.text(
                        AppStrings.ageValuePlaceholder,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          15.hBox,
          Obx(
            () => SwitchCard(
              text: AppStrings.showMoreProfiles,
              isSwitch: controller.isSwitchOn.value,
              onChanged: (value) {
                controller.toggleSwitch(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
