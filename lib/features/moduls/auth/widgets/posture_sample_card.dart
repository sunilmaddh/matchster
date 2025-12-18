import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class PostureSampleCard extends StatelessWidget {
  const PostureSampleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 159.h,
      decoration: BoxDecoration(
        gradient: AppColors.gradiantPrimary,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Image.asset(AppAssets.posture1),
    );
  }
}
