import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class SwitchCard extends StatelessWidget {
  const SwitchCard({
    super.key,
    required this.text,
    required this.isSwitch,
    required this.onChanged,
  });
  final String text;
  final bool isSwitch;
  final Function(bool isToggelSwitch) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText.labelMedium(
          text,
          fontWeight: FontWeight.w400,
          color: AppColors.distenceSwitchTextColor,
        ),
        GradientSwitch(
          value: isSwitch,
          onChanged: (bool value) {
            onChanged(value);
          },
        ),
      ],
    );
  }
}

class GradientSwitch extends StatelessWidget {
  const GradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.color = Colors.white,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 46,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:
              value
                  ? AppColors.gradientBoxCircle
                  : LinearGradient(
                    colors: [Color(0xffD9D9D9), Color(0xffD9D9D9)],
                  ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26)],
            ),
          ),
        ),
      ),
    );
  }
}
