import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';

class MatchCardWidget extends StatelessWidget {
  const MatchCardWidget({super.key, this.isBlur = false});

  final bool isBlur;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 135.w,
          top: 1.h,
          child: Transform.rotate(
            angle: 0.1,
            child: Container(
              width: 160.w,
              height: 160.h,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE6D534),
              ),
              child: ImageFiltered(
                imageFilter:
                    isBlur
                        ? ImageFilter.blur(sigmaX: 5, sigmaY: 3)
                        : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: ClipOval(
                  child: Image.asset(AppAssets.imageAssets5, fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ),

        Positioned(
          left: 10.w,
          top: 101.h,
          child: Transform.rotate(
            angle: -0.1,
            child: Container(
              width: 160.w,
              height: 160.h,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffADE2FF),
              ),
              child: ImageFiltered(
                imageFilter:
                    isBlur
                        ? ImageFilter.blur(sigmaX: 3, sigmaY: 5)
                        : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: ClipOval(
                  child: Image.asset(AppAssets.imageAssets8, fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
