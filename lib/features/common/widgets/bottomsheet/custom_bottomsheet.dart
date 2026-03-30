import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  static Future<T?> show<T>({
    required Widget child,
    bool isScrollControlled = true,
    Color backgroundColor = Colors.white,
    double borderRadius = 20.0,
    EdgeInsetsGeometry? padding,
  }) {
    return Get.bottomSheet<T>(
      SafeArea(
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
          ),
          child: child,
        ),
      ),
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
    );
  }
}
