import 'package:matchster/core/enum/enum.dart';

extension HeightEnumExt on HeightEnum {
  String get emoji {
    switch (this) {
      case HeightEnum.height:
        return "📏";
    }
  }

  String get apiValue {
    switch (this) {
      case HeightEnum.height:
        return "height";
    }
  }

  static HeightEnum? fromApi(String apiValue) {
    return HeightEnum.values.firstWhere(
      (e) => e.apiValue == apiValue.toLowerCase(),
      orElse: () => HeightEnum.height,
    );
  }
}

extension CapitalizeListExtension on List<String> {
  List<String> capitalizeFirstLetterOfListString() {
    return map((text) {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1);
    }).toList();
  }
}

extension CapitalizeString on String {
  String capitalizeFirstOfList() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension CapitalizeJoinExtension on List<String> {
  String capitalizeFirstAndJoin({String separator = ", "}) {
    return map((e) {
      if (e.trim().isEmpty) return e;

      return e
          .replaceAll('_', ' ')
          .split(' ')
          .map(
            (word) =>
                word.isEmpty ? word : word[0].toUpperCase() + word.substring(1),
          )
          .join(' ');
    }).join(separator);
  }
}
