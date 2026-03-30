import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';

class PostureSampleCard extends StatelessWidget {
  const PostureSampleCard({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 159.h,
      decoration: BoxDecoration(
        gradient: AppColors.gradiantPrimary,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Image.asset(image, fit: BoxFit.fill),
    );
  }
}
