import 'package:matchster/core/enum/enum.dart';

extension VisibilityEnumX on VisibilityEnum {
  /// Human-readable label (UI)
  String get label {
    switch (this) {
      case VisibilityEnum.everyone:
        return "Everyone";
      case VisibilityEnum.myPreferenceOnly:
        return "My preference only";
      case VisibilityEnum.myMatches:
        return "My matches";
    }
  }

  /// Value for API / storage
  String get apiValue => name;
}
