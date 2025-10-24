// lib/core/widgets/fields/radio_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';

class RadioWidget extends StatelessWidget {
  final String text;
  final int index;

  const RadioWidget({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardController>();

    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;

      return GestureDetector(
        onTap: () => controller.toggleSelection(index),
        child: Container(
          padding: 10.horizontalPadding,
          width: MediaQuery.of(context).size.width,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color:
                  isSelected
                      ? const Color(0xFF1B8CF5)
                      : const Color(0xFFEBEBEB),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText.text(
                text,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SvgPicture.asset(
                isSelected ? AppAssets.radioEnable : AppAssets.radioDisable,
              ),
            ],
          ),
        ),
      );
    });
  }
}
