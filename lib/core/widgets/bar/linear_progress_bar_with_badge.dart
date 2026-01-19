// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:matchster/core/constants/app_assets.dart';
// import 'package:matchster/core/constants/app_colors.dart';
// import 'package:matchster/core/utils/extentions.dart';

// // ignore: must_be_immutable
// class LinearProgressBarWithBadge extends StatelessWidget {
//   LinearProgressBarWithBadge({super.key});
//   double progress = 0.50;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70.h,
//       child: Stack(
//         alignment: Alignment.centerLeft,
//         children: [
//           // 🔹 Background bar
//           Container(
//             height: 7.h,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Color(0xffDEDEDE), width: 4),
//             ),
//           ),

//           // 🔹 Filled portion
//           Container(
//             margin: EdgeInsets.all(4),
//             width: 300 * progress,
//             height: 5.h,
//             decoration: BoxDecoration(
//               gradient: AppColors.gradiantPrimary,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),

//           // 🔹 Circular badge
//           Positioned(
//             left: 300 * progress - 15, // center badge on progress
//             child: SvgPicture.asset(
//               height: 15.h,
//               width: 15.w,
//               AppAssets.radioEnable,
//             ),
//             // Container(
//             //   width: 30, // badge width
//             //   height: 30, // badge height
//             //   decoration: BoxDecoration(
//             //     color: Colors.orange,
//             //     shape: BoxShape.circle,
//             //     boxShadow: [
//             //       BoxShadow(
//             //         color: Colors.black26,
//             //         blurRadius: 4,
//             //         offset: Offset(0, 2),
//             //       ),
//             //     ],
//             //   ),
//             //   alignment: Alignment.center,
//             //   child: Text(
//             //     "${(progress * 100).toInt()}%",
//             //     style: const TextStyle(
//             //       color: Colors.white,
//             //       fontWeight: FontWeight.bold,
//             //       fontSize: 12,
//             //     ),
//             //   ),
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class LinearProgressBarWithBadge extends StatefulWidget {
  const LinearProgressBarWithBadge({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
  });

  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  State<LinearProgressBarWithBadge> createState() =>
      _LinearProgressBarWithBadgeState();
}

class _LinearProgressBarWithBadgeState
    extends State<LinearProgressBarWithBadge> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant LinearProgressBarWithBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final percent = (_currentValue - widget.min) / (widget.max - widget.min);

    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final thumbSize = 16.h;
        final thumbLeft = (trackWidth * percent).clamp(
          0.0,
          trackWidth - thumbSize,
        );

        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            final dx = details.localPosition.dx.clamp(0.0, trackWidth);
            final newValue =
                widget.min + (dx / trackWidth) * (widget.max - widget.min);

            setState(() => _currentValue = newValue);
            widget.onChanged(newValue);
          },
          child: SizedBox(
            height: 48.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                /// Track
                Positioned(
                  top: 10.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 10.h,
                    width: trackWidth * percent,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradientBoxCircle,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  left: thumbLeft - 12.w,
                  top: 4.h,
                  child: Column(
                    children: [
                      Container(
                        height: thumbSize,
                        width: thumbSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.gradientBoxCircle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(38),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(1.5.r), // border thickness
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 1.h),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 200),
                        tween: Tween(begin: 0, end: _currentValue),
                        builder: (_, value, __) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return AppColors.appGradiantColor.createShader(
                                Rect.fromLTWH(
                                  0,
                                  0,
                                  bounds.width,
                                  bounds.height,
                                ),
                              );
                            },
                            blendMode: BlendMode.srcIn,
                            child: CommonText.text(
                              "${value.round().toString()}%",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
