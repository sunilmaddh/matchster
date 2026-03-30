import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class AnimatedSeekBar extends StatefulWidget {
  const AnimatedSeekBar({
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
  State<AnimatedSeekBar> createState() => _AnimatedSeekBarState();
}

class _AnimatedSeekBarState extends State<AnimatedSeekBar> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant AnimatedSeekBar oldWidget) {
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
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 6.h,
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
                  left: thumbLeft - 3.w,
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

                      SizedBox(height: 6.h),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 200),
                        tween: Tween(begin: 0, end: _currentValue),
                        builder: (_, value, __) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return AppColors.gradientBoxCircle.createShader(
                                Rect.fromLTWH(
                                  0,
                                  0,
                                  bounds.width,
                                  bounds.height,
                                ),
                              );
                            },
                            blendMode: BlendMode.srcIn,
                            child: CommonText.labelLarge(
                              value.round().toString(),
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
