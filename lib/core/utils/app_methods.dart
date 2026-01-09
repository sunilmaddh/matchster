import 'package:flutter/material.dart';

class AppMethods {
  static String capitalizeFirst(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  static void appPrint({required String message}) {
    debugPrint(message);
  }
}
