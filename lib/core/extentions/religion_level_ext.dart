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
      case ReligionEnum.muism:
        return "Mu-ism";
      case ReligionEnum.confucianism:
        return "Confucianism";
      case ReligionEnum.bahaiFaith:
        return "Baháʼí Faith";
      case ReligionEnum.others:
        return "Others";
    }
  }

  /// Value used for API / storage
  String get apiValue => name;
}
