import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtils {
  /// Responsive width based on design width
  static double width(double value) => value.w;

  /// Responsive height based on design height
  static double height(double value) => value.h;

  /// Responsive font size
  static double fontSize(double value) => value.sp;

  /// Responsive radius for rounded corners
  static double radius(double value) => value.r;

  /// Horizontal padding / margin
  static double kHorizontal(double value) => value.w;

  /// Vertical padding / margin
  static double kVertical(double value) => value.h;

  /// Symmetric padding helper
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(
        horizontal: kHorizontal(horizontal),
        vertical: kVertical(vertical),
      );

  /// All-side padding helper
  static EdgeInsets all(double value) => EdgeInsets.all(width(value));

  /// Only padding helper
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: width(left),
    top: height(top),
    right: width(right),
    bottom: height(bottom),
  );
}
