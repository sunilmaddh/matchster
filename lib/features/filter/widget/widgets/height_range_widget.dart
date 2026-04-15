import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/switch_card.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/seek_bar_widget.dart';
import 'package:matchster/features/chat/widget/text_with_widget.dart';
import 'package:matchster/features/filter/widget/widgets/animated_range_seek_bar.dart';

class HeightRangeWidget extends StatelessWidget {
  const HeightRangeWidget({super.key, required this.controller});
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      isBorder: false,
      color: AppColors.filterCardColor,
      widget: Column(
        children: [
          TextWithWidget(
            title: AppStrings.filterString.heightRange,
            subTitle: AppStrings.filterString.heigthSub,
            widget: AnimatedRangeSeekBar(
              endValue: 50,
              onChanged: (v) {},
              startValue: 0,
            ),
          ),
          15.hBox,
          Obx(
            () => SwitchCard(
              text: AppStrings.filterString.showMeMoreProfile,
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
