import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class AnimatedRangeSeekBar extends StatefulWidget {
  const AnimatedRangeSeekBar({
    super.key,
    required this.startValue,
    required this.endValue,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
  });

  final double startValue;
  final double endValue;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;

  @override
  State<AnimatedRangeSeekBar> createState() => _AnimatedRangeSeekBarState();
}

class _AnimatedRangeSeekBarState extends State<AnimatedRangeSeekBar> {
  late double _startValue;
  late double _endValue;

  bool _isDraggingStart = false;
  bool _isDraggingEnd = false;

  @override
  void initState() {
    super.initState();
    _startValue = widget.startValue;
    _endValue = widget.endValue;
  }

  @override
  void didUpdateWidget(covariant AnimatedRangeSeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _startValue = widget.startValue;
    _endValue = widget.endValue;
  }

  double _valueToPosition(double value, double trackWidth) {
    final percent = (value - widget.min) / (widget.max - widget.min);
    return percent * trackWidth;
  }

  double _positionToValue(double dx, double trackWidth) {
    final clampedDx = dx.clamp(0.0, trackWidth);
    return widget.min + (clampedDx / trackWidth) * (widget.max - widget.min);
  }

  void _handleDragStart(Offset localPosition, double trackWidth) {
    final startX = _valueToPosition(_startValue, trackWidth);
    final endX = _valueToPosition(_endValue, trackWidth);

    final distanceToStart = (localPosition.dx - startX).abs();
    final distanceToEnd = (localPosition.dx - endX).abs();

    if (distanceToStart <= distanceToEnd) {
      _isDraggingStart = true;
      _isDraggingEnd = false;
    } else {
      _isDraggingStart = false;
      _isDraggingEnd = true;
    }
  }

  void _handleDragUpdate(Offset localPosition, double trackWidth) {
    final newValue = _positionToValue(localPosition.dx, trackWidth);

    setState(() {
      if (_isDraggingStart) {
        _startValue = newValue.clamp(widget.min, _endValue);
      } else if (_isDraggingEnd) {
        _endValue = newValue.clamp(_startValue, widget.max);
      }
    });

    widget.onChanged(RangeValues(_startValue, _endValue));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final thumbSize = 16.h;

        final startPercent =
            (_startValue - widget.min) / (widget.max - widget.min);
        final endPercent = (_endValue - widget.min) / (widget.max - widget.min);

        final startLeft = (trackWidth * startPercent).clamp(
          0.0,
          trackWidth - thumbSize,
        );
        final endLeft = (trackWidth * endPercent).clamp(
          0.0,
          trackWidth - thumbSize,
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (details) {
            _handleDragStart(details.localPosition, trackWidth);
          },
          onHorizontalDragUpdate: (details) {
            _handleDragUpdate(details.localPosition, trackWidth);
          },
          onHorizontalDragEnd: (_) {
            _isDraggingStart = false;
            _isDraggingEnd = false;
          },
          child: SizedBox(
            height: 65.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
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
                  left: startLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 6.h,
                    width: (endLeft - startLeft).clamp(0.0, trackWidth),
                    decoration: BoxDecoration(
                      gradient: AppColors.gradientBoxCircle,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  left: startLeft - 3.w,
                  top: 4.h,
                  child: _ThumbWithLabel(value: _startValue),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  left: endLeft - 3.w,
                  top: 4.h,
                  child: _ThumbWithLabel(value: _endValue),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThumbWithLabel extends StatelessWidget {
  const _ThumbWithLabel({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 16.h,
          width: 16.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.gradientBoxCircle,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(38), blurRadius: 6),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(1.5.r),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        ShaderMask(
          shaderCallback: (bounds) {
            return AppColors.gradientBoxCircle.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          blendMode: BlendMode.srcIn,
          child: CommonText.text(
            value.round().toString(),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
