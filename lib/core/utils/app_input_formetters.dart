import 'package:flutter/services.dart';

class AppInputFormatters {
  /// Allows only alphabets (A–Z, a–z) and space
  static TextInputFormatter onlyCharacters({bool allowSpace = true}) {
    return FilteringTextInputFormatter.allow(
      RegExp(allowSpace ? r'[a-zA-Z\s]' : r'[a-zA-Z]'),
    );
  }

  /// Allows only numbers
  static TextInputFormatter onlyNumbers() {
    return FilteringTextInputFormatter.digitsOnly;
  }

  /// Allows alphanumeric characters
  static TextInputFormatter alphaNumeric() {
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));
  }

  /// Max length limiter
  static TextInputFormatter maxLength(int length) {
    return LengthLimitingTextInputFormatter(length);
  }

  static TextInputFormatter firstLetterCapital() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;

      final text = newValue.text;
      final updatedText = text[0].toUpperCase() + text.substring(1);

      return newValue.copyWith(
        text: updatedText,
        selection: TextSelection.collapsed(offset: updatedText.length),
      );
    });
  }
}
