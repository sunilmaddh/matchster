import 'package:matchster/core/enum/enum.dart';

extension SmokDrinkPreferenceExt on SmokDrinkPreference {
  String get displayName {
    switch (this) {
      case SmokDrinkPreference.doesntMatter:
        return "Doesn't Matter";
      case SmokDrinkPreference.yes:
        return "Yes";
      case SmokDrinkPreference.socially:
        return "Socially";
      case SmokDrinkPreference.occasionally:
        return "Occasionally";
      case SmokDrinkPreference.never:
        return "Never";
    }
  }

  static List<String> get list =>
      SmokDrinkPreference.values.map((e) => e.displayName).toList();
}
