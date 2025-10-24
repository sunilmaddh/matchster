import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardController>();

    return Container(
      padding: 10.horizontalPadding,
      width: MediaQuery.of(context).size.width,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xffEBEBEB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.text(
            "Show on your profile",
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
          Obx(
            () => Switch(
              padding: EdgeInsets.zero,
              value: controller.isSwitchOn.value,
              onChanged: controller.toggleSwitch,
            ),
          ),
        ],
      ),
    );
  }
}
