import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';

class LinearProgressBarWithBadge extends StatelessWidget {
  LinearProgressBarWithBadge({super.key});
  double progress = 0.50;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 🔹 Background bar
          Container(
            height: 7.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffDEDEDE), width: 4),
            ),
          ),

          // 🔹 Filled portion
          Container(
            margin: EdgeInsets.all(4),
            width: 300 * progress,
            height: 5.h,
            decoration: BoxDecoration(
              gradient: AppColors.gradiantPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // 🔹 Circular badge
          Positioned(
            left: 300 * progress - 15, // center badge on progress
            child: SvgPicture.asset(
              height: 15.h,
              width: 15.w,
              AppAssets.radioEnable,
            ),
            // Container(
            //   width: 30, // badge width
            //   height: 30, // badge height
            //   decoration: BoxDecoration(
            //     color: Colors.orange,
            //     shape: BoxShape.circle,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black26,
            //         blurRadius: 4,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   alignment: Alignment.center,
            //   child: Text(
            //     "${(progress * 100).toInt()}%",
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 12,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
