import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/card/circle_gradiant_card.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({
    super.key,
    this.isGradient = true,
    required this.image,
    required this.text,
    required this.onTop,
  });
  final bool isGradient;
  final String image;
  final String text;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "like_dislike",
      child: GestureDetector(
        onTap: onTop,
        child: Column(
          children: [
            CircleGradiantCard(
              isGradiant: isGradient,
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(image),
              ),
            ),
            5.hBox,
            CommonText.labelSmall(text, color: AppColors.whiteColor),
          ],
        ),
      ),
    );
  }
}
