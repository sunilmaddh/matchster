import 'package:matchster/core/enum/enum.dart';

extension LookingPreferenceExt on LookingForPreference {
  String get displayName {
    switch (this) {
      case LookingForPreference.doesntMatter:
        return "Doesn't Matter";
      case LookingForPreference.relationship:
        return "Relationship";
      case LookingForPreference.casualRelationship:
        return "Casual Relationship";
      case LookingForPreference.friendship:
        return "Friendship";
      case LookingForPreference.marriage:
        return "Marriage";
      case LookingForPreference.dontKnowYet:
        return "Don't Know Yet";
    }
  }

  static List<String> get list =>
      LookingForPreference.values.map((e) => e.displayName).toList();
}
