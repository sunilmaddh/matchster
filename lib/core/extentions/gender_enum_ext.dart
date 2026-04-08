import 'package:matchster/core/enum/enum.dart';

extension GenderEnumX on GenderEnum {
  /// Emoji for UI
  String get emoji {
    switch (this) {
      case GenderEnum.men:
        return "👨🏽";
      case GenderEnum.women:
        return "👩";
      case GenderEnum.others:
        return "🧑";
    }
  }

  /// Human-readable label
  String get label {
    switch (this) {
      case GenderEnum.men:
        return "Men";
      case GenderEnum.women:
        return "Women";
      case GenderEnum.others:
        return "Others";
    }
  }

  /// API value
  String get apiValue {
    switch (this) {
      case GenderEnum.men:
        return "men";
      case GenderEnum.women:
        return "women";
      case GenderEnum.others:
        return "others";
    }
  }

  /// API → Enum
  static GenderEnum? fromApi(String value) {
    return GenderEnum.values.firstWhere(
      (e) => e.apiValue == value.toLowerCase(),
      orElse: () => GenderEnum.others,
    );
  }
}
