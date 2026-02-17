import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtension on num {
  double get w => ScreenUtil().setWidth(toDouble());
  double get h => ScreenUtil().setHeight(toDouble());
  double get sp => ScreenUtil().setSp(toDouble());
  double get r => ScreenUtil().radius(toDouble());

  SizedBox get hBox => SizedBox(height: h);
  SizedBox get wBox => SizedBox(width: w);
}

extension EdgeInsetsExtension on num {
  EdgeInsets get allPadding => EdgeInsets.all(SizeExtension(toDouble()).w);
  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: SizeExtension(toDouble()).w);
  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: SizeExtension(toDouble()).h);
}
