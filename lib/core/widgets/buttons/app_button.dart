import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.name,
    required this.onTop,
    required this.isEnable,
    this.image = '',
  });
  final String name;
  final VoidCallback onTop;
  final String image;
  RxBool isEnable = false.obs;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:
              isEnable.value
                  ? AppColors.gradiantPrimary
                  : AppColors.appGradiantColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            10.wBox,
            CommonText.text(
              fontFamily: "Caros",
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              name,
              color:
                  isEnable.value
                      ? AppColors.whiteColor
                      : AppColors.appDisableButton,
            ),
          ],
        ),
      ),
    );
  }
}
