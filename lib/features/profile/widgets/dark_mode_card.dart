import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/switch_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class DarkModeCard extends StatelessWidget {
  const DarkModeCard({
    super.key,
    required this.isSwitchOn,
    required this.onChanged,
    required this.text,
  });

  final bool isSwitchOn;
  final String text;
  final Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 15.horizontalPadding,
      height: 58.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        // ignore: deprecated_member_use
        border: Border.all(width: 1.w, color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.titleLarge(text, fontWeight: FontWeight.w600),
          GradientSwitch(value: isSwitchOn, onChanged: onChanged),
          // Switch(
          //   focusColor: Color(0xff1D48EF),
          //   activeTrackColor: Color(0xff1D48EF),
          //   padding: EdgeInsets.zero,
          //   value: isSwitchOn,
          //   onChanged: onChanged,
          //   // ← Select All / Unselect All
          // ),
        ],
      ),
    );
  }
}
