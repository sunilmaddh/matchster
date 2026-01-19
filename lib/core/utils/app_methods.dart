import 'package:flutter/material.dart';

class AppMethods {
  static String capitalizeFirst(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  static void appPrint({required String message}) {
    debugPrint(message);
  }

  static Future<List<String>> toApiValues(List<String> uiValues) async {
    return uiValues.map((value) {
      return value
          .replaceAll(RegExp(r'[^\w\s]'), '') // remove emojis & symbols
          .trim()
          .toLowerCase()
          .replaceAll(' ', '_'); // optional for snake_case
    }).toList();
  }

  String formatDateToDDMMYYYY(String date) {
    if (date.isEmpty) return "";

    try {
      final parts = date.split('-');
      if (parts.length != 3) return date;

      final year = parts[0];
      final month = parts[1];
      final day = parts[2];

      return "$day-$month-$year";
    } catch (_) {
      return date;
    }
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
