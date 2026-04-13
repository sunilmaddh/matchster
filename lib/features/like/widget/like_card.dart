import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class LikeCard extends StatelessWidget {
  const LikeCard({
    super.key,
    required this.image,
    required this.text1,
    required this.text2,
    this.isBlur = false,
  });

  final String image;
  final String text1;
  final String text2;
  final bool isBlur;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter:
          isBlur
              ? ImageFilter.blur(sigmaX: 5, sigmaY: 3)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CommonAssets.networkImage(image, fit: BoxFit.cover),
          ),
          5.hBox,
          CommonText.labelMedium(text1, color: Color(0xff1D48EF)),
          CommonText.titleMedium(text2, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
