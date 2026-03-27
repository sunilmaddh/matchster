import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/switch_card.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/features/modules/auth/widgets/onboard_widget/toggle_button_widget.dart';
import 'package:matchster/features/modules/home/controller/filter_controller.dart';
import 'package:matchster/features/modules/home/widgets/seek_bar_widget.dart';
import 'package:matchster/features/modules/home/widgets/text_with_widget.dart';

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
                  title: "Distance",
                  subTitle: "How for away are they?",
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
              text: "Show me more profiles if I run out.",
              isSwitch: controller.isSwitchOn.value,
              onChanged: (value) {
                controller.toggleSwitch(value);
              },
            ),
          ),
        ],
      ),
    );
    ;
  }
}
