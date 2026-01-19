import 'package:matchster/core/enum/enum.dart';

extension LanguageEnumX on LanguageEnum {
  /// Human-readable label (UI)
  String get label {
    switch (this) {
      case LanguageEnum.hindi:
        return "Hindi";
      case LanguageEnum.english:
        return "English";
      case LanguageEnum.gujarati:
        return "Gujarati";
      case LanguageEnum.assamese:
        return "Assamese";
      case LanguageEnum.bengali:
        return "Bengali";
      case LanguageEnum.marathi:
        return "Marathi";
      case LanguageEnum.nepali:
        return "Nepali";
      case LanguageEnum.spanish:
        return "Spanish";
      case LanguageEnum.french:
        return "French";
      case LanguageEnum.urdu:
        return "Urdu";
      case LanguageEnum.arabic:
        return "Arabic";
      case LanguageEnum.portuguese:
        return "Portuguese";
      case LanguageEnum.russian:
        return "Russian";
      case LanguageEnum.indonesian:
        return "Indonesian";
      case LanguageEnum.german:
        return "German";
      case LanguageEnum.japanese:
        return "Japanese";
      case LanguageEnum.turkish:
        return "Turkish";
      case LanguageEnum.chinese:
        return "Chinese";
      case LanguageEnum.korean:
        return "Korean";
      case LanguageEnum.tamil:
        return "Tamil";
      case LanguageEnum.telugu:
        return "Telugu";
      case LanguageEnum.punjabi:
        return "Punjabi";
      case LanguageEnum.italian:
        return "Italian";
      case LanguageEnum.malayalam:
        return "Malayalam";
      case LanguageEnum.dutch:
        return "Dutch";
      case LanguageEnum.greek:
        return "Greek";
      case LanguageEnum.thai:
        return "Thai";
      case LanguageEnum.swedish:
        return "Swedish";
      case LanguageEnum.vietnamese:
        return "Vietnamese";
    }
  }

  /// Value for API / storage
  String get apiValue => name;
}
