import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';

class DarkCircleWidget extends StatelessWidget {
  const DarkCircleWidget({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32.h,
      width: 32.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff797979),
      ),
      child: widget,
    );
  }
}
