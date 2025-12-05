import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.name,
    required this.onTop,
    required this.isEnable,
  });
  final String name;
  final VoidCallback onTop;
  final RxBool isEnable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Obx(
        () => Container(
          alignment: Alignment.center,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:
                isEnable.isTrue
                    ? AppColors.gradiantPrimary
                    : AppColors.appGradiantColor,
          ),
          child: CommonText.text(
            name,
            color:
                isEnable.isTrue
                    ? AppColors.whiteColor
                    : AppColors.appDisableButton,
          ),
        ),
      ),
    );
  }
}
