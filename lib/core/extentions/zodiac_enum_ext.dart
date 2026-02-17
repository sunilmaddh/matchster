import 'package:matchster/core/enum/enum.dart';

extension ZodiacEnumX on ZodiacEnum {
  /// Human-readable label (UI)
  String get label {
    switch (this) {
      case ZodiacEnum.aries:
        return "Aries";
      case ZodiacEnum.taurus:
        return "Taurus";
      case ZodiacEnum.gemini:
        return "Gemini";
      case ZodiacEnum.cancer:
        return "Cancer";
      case ZodiacEnum.leo:
        return "Leo";
      case ZodiacEnum.virgo:
        return "Virgo";
      case ZodiacEnum.libra:
        return "Libra";
      case ZodiacEnum.scorpio:
        return "Scorpio";
      case ZodiacEnum.sagittarius:
        return "Sigatarius"; // updated spelling
      case ZodiacEnum.capricorn:
        return "Capricorn";
      case ZodiacEnum.aquarius:
        return "Aquarious"; // updated spelling
      case ZodiacEnum.pisces:
        return "Pisces";
    }
  }

  String get emoji {
    return "⚛";
  }

  /// Value for API / storage
  String get apiValue => name;

  static ZodiacEnum? fromApi(String value) {
    return ZodiacEnum.values.firstWhere(
      (e) => e.apiValue == value.toLowerCase(),
      orElse: () => ZodiacEnum.gemini,
    );
  }
}
