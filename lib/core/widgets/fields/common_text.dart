import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matchster/core/constants/app_text_style.dart';

class CommonText {
  /// Common styled text
  static Widget text(
    String text, {
    double fontSize = 16.0,
    Key? key,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    String fontFamily = AppTextStyles.fontFamily,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextDecoration? decoration,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(
      key: key,
      text,
      style: TextStyle(
        decoration: decoration,
        fontFamily: fontFamily,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
