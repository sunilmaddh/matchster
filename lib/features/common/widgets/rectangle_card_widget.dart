import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';

class RectangleCardWidget extends StatelessWidget {
  const RectangleCardWidget({super.key, this.isBlur = false});

  final bool isBlur;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: Stack(
        children: [
          Positioned(
            left: 80.w,
            top: 4.h,

            child: Transform.rotate(
              angle: 0.1,
              child: Container(
                width: 76.w,
                height: 77.h,
                padding: EdgeInsets.all(0.5.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff1B8CF5), Color(0xff7505C9)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ImageFiltered(
                  imageFilter:
                      isBlur
                          ? ImageFilter.blur(sigmaX: 5, sigmaY: 3)
                          : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      AppAssets.imageAssets5,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // RIGHT CARD
          Positioned(
            left: 20.w,
            top: 3.h,
            child: Transform.rotate(
              angle: -0.11,
              child: Container(
                width: 76.w,
                height: 77.h,
                padding: EdgeInsets.all(1.r), // border thickness
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff1B8CF5), Color(0xff7505C9)],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ImageFiltered(
                  imageFilter:
                      isBlur
                          ? ImageFilter.blur(sigmaX: 3, sigmaY: 5)
                          : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      18.r,
                    ), // inner radius = outer - border
                    child: Image.asset(
                      AppAssets.imageAssets8,
                      width: 76.w,
                      height: 77.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
