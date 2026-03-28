import 'package:flutter/material.dart';
import 'package:matchster/core/extentions/extentions.dart';

class DarkCircleWidget extends StatelessWidget {
  const DarkCircleWidget({
    super.key,
    required this.widget,
    required this.onTop,
  });
  final Widget widget;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        alignment: Alignment.center,
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff797979),
        ),
        child: widget,
      ),
    );
  }
}
