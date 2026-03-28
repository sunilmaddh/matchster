import 'package:flutter/material.dart';
import 'package:matchster/core/extentions/extentions.dart';

class SubCommonCard extends StatelessWidget {
  const SubCommonCard({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 10.horizontalPadding + 4.verticalPadding,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9).withAlpha(33),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Color(0xff363636).withAlpha(33), width: 1.w),
      ),
      child: widget,
    );
  }
}
