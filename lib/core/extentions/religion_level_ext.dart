import 'package:matchster/core/enum/enum.dart';

extension ReligionEnumX on ReligionEnum {
  /// Human-readable label (UI)
  String get label {
    switch (this) {
      case ReligionEnum.agnostic:
        return "Agnostic";
      case ReligionEnum.atheist:
        return "Atheist";
      case ReligionEnum.christian:
        return "Christian";
      case ReligionEnum.muslim:
        return "Muslim";
      case ReligionEnum.hindu:
        return "Hindu";
      case ReligionEnum.buddhist:
        return "Buddhist";
      case ReligionEnum.jain:
        return "Jain";
      case ReligionEnum.sikh:
        return "Sikh";
      case ReligionEnum.spiritual:
        return "Spiritual";
      case ReligionEnum.mormon:
        return "Mormon";
      case ReligionEnum.jewish:
        return "Jewish";
      case ReligionEnum.zoroastrian:
        return "Zoroastrian";
      case ReligionEnum.shinto:
        return "Shinto";
      case ReligionEnum.tao:
        return "Tao";
      case ReligionEnum.voodoo:
        return "Voodoo";
      case ReligionEnum.spiritism:
        return "Spiritism";
      // case ReligionEnum.muism:
      //   return "Mu-ism";
      case ReligionEnum.confucianism:
        return "Confucianism";
      case ReligionEnum.bahaiFaith:
        return "Baháʼí Faith";
      case ReligionEnum.perfecttonotsay:
        return "Prefer not to say";
    }
  }

  /// Value used for API / storage
  String get apiValue => name;
  String get emoji {
    return "🙏🏼";
  }

  static ReligionEnum? fromApi(String value) {
    return ReligionEnum.values.firstWhere(
      (e) => e.apiValue == value.toLowerCase(),
      orElse: () => ReligionEnum.perfecttonotsay,
    );
  }

  static List<String> get list =>
      ReligionEnum.values.map((e) => e.label).toList();
}
