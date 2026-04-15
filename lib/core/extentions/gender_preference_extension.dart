import 'package:matchster/core/enum/enum.dart';

extension GenderPreferenceExtension on GenderPreference {
  String get displayName {
    switch (this) {
      case GenderPreference.men:
        return "Men";
      case GenderPreference.women:
        return "Women";
      case GenderPreference.others:
        return "Others";
      case GenderPreference.openToDateEverybody:
        return "Open to Date Everybody";
    }
  }

  String get apiValue {
    switch (this) {
      case GenderPreference.men:
        return "men";
      case GenderPreference.women:
        return "women";
      case GenderPreference.others:
        return "others";
      case GenderPreference.openToDateEverybody:
        return "open_to_date_everybody";
    }
  }

  static List<String> get list =>
      GenderPreference.values.map((e) => e.displayName).toList();
}
