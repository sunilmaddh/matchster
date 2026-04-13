import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.name,
    required this.onTop,
    this.isEnable = false,
    this.image = '',
    this.isBlack = false,
  });
  final String name;
  final VoidCallback onTop;
  final String image;
  final bool isEnable;
  final bool isBlack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        alignment: Alignment.center,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          color: isBlack ? AppColors.loginTitleColor : AppColors.primary,

          gradient:
              isBlack
                  ? null
                  : isEnable
                  ? AppColors.gradiantPrimary
                  : AppColors.appGradiantColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image.isNotEmpty ? SvgPicture.asset(image) : SizedBox.shrink(),
            10.wBox,
            CommonText.titleMedium(
              fontWeight: FontWeight.w400,
              name,
              color:
                  isEnable ? AppColors.whiteColor : AppColors.appDisableButton,
            ),
          ],
        ),
      ),
    );
  }
}
