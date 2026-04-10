import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/switch_card.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/seek_bar_widget.dart';
import 'package:matchster/features/chat/widget/text_with_widget.dart';

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
            title: "Age",
            subTitle: "Set preferred age range?",
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
                        "gg",
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
  }
}
