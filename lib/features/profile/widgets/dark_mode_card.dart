import 'package:flutter/material.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

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
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        // ignore: deprecated_member_use
        border: Border.all(width: 1.w, color: Colors.black.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.text(text, fontSize: 17.sp, fontWeight: FontWeight.w600),
          Switch(
            focusColor: Color(0xff1D48EF),
            activeTrackColor: Color(0xff1D48EF),
            padding: EdgeInsets.zero,
            value: isSwitchOn,
            onChanged: onChanged,
            // ← Select All / Unselect All
          ),
        ],
      ),
    );
  }
}
