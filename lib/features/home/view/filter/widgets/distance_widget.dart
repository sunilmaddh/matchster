import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/card/switch_card.dart';
import 'package:matchster/features/common/widgets/fields/common_card.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/toggle_button_widget.dart';
import 'package:matchster/features/home/controller/filter_controller.dart';
import 'package:matchster/features/home/widgets/seek_bar_widget.dart';
import 'package:matchster/features/home/widgets/text_with_widget.dart';

class DistanceWidget extends StatelessWidget {
  const DistanceWidget({super.key, required this.controller});
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      isBorder: false,
      color: AppColors.filterCardColor,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextWithWidget(
                  title: AppStrings.distanceTitle,
                  subTitle: AppStrings.distanceSubtitle,
                  widget: AnimatedSeekBar(value: 50, onChanged: (v) {}),
                ),
              ),
              ToggleWithText(
                controller: controller,
                onTop1: () {
                  controller.isKm.value = true;
                },
                onTop2: () {
                  controller.isKm.value = false;
                },
              ),
            ],
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
