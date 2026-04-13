import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.name,
    required this.onTop,
    this.image = "",
  });
  final String name;
  final String image;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          color: Color(0xff161E3E),
          borderRadius: BorderRadius.circular(20.0),
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
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
