import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchster/core/extentions/date_x_ext.dart';

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

  static bool isValid(String value) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }

  static String? validateWorkText({required String value}) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (!isValid(value)) {
      return "Please enter valid text";
    }
    return null;
  }

  static bool isValidIndianMobile(String mobile) {
    final regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(mobile);
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) return null;

    // ❌ FIRST DIGIT CHECK (show error immediately)
    if (value.length == 1 && !RegExp(r'[6-9]').hasMatch(value)) {
      return 'Enter a valid mobile number';
    }

    // ⏳ Don't validate while typing (2–9 digits)
    if (value.length < 10) return null;

    // ✅ FULL NUMBER VALIDATION
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Enter a valid mobile number';
    }

    return null;
  }

  String toSnakeCase(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');
  }

  static String? validateText(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^.{3,}$').hasMatch(value)) {
      return 'Enter at least 3 characters';
    }
    return null;
  }

  static bool isAge18OrAbove(DateTime dob) {
    final today = DateTime.now();

    int age = today.year - dob.year;

    // If birthday hasn't occurred yet this year, subtract 1
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }

    return age >= 18;
  }

  String formatToTwoDecimals(String value) {
    return double.parse(value).toStringAsFixed(2);
  }

  static Map<String, String> formatFromIso(String rawDate) {
    if (rawDate.isEmpty) {
      return {'ui': '', 'api': ''};
    }

    final DateTime date = DateTime.parse(rawDate).toLocal();

    return {
      'ui': date.readable, // UI
      'api': DateFormat('yyyy-MM-dd').format(date), // API
    };
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
