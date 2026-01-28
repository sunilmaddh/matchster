import 'package:matchster/core/enum/enum.dart';

extension RelationshipIntentEnumX on RelationshipIntentEnum {
  /// Human-readable label (UI)
  ///
  ///
  String get apiValue {
    switch (this) {
      case RelationshipIntentEnum.relationship:
        return "relationship";
      case RelationshipIntentEnum.casualRelationship:
        return "casual_relationship";
      case RelationshipIntentEnum.friendship:
        return "friendship";
      case RelationshipIntentEnum.marriage:
        return "marriage";
      case RelationshipIntentEnum.networking:
        return "networking";
      case RelationshipIntentEnum.dontKnowYet:
        return "dont_know_yet";
      case RelationshipIntentEnum.preferNotToSay:
        return "prefer_not_to_say";
    }
  }

  String get label {
    switch (this) {
      case RelationshipIntentEnum.relationship:
        return "Relationship";
      case RelationshipIntentEnum.casualRelationship:
        return "Casual Relationship";
      case RelationshipIntentEnum.friendship:
        return "Friendship";
      case RelationshipIntentEnum.marriage:
        return "Marriage";
      case RelationshipIntentEnum.networking:
        return "Networking";
      case RelationshipIntentEnum.dontKnowYet:
        return "Don’t know yet";
      case RelationshipIntentEnum.preferNotToSay:
        return "Prefer not to say";
    }
  }

  /// Value for API / storage
  // String get apiValue => name;

  String get emoji {
    switch (this) {
      case RelationshipIntentEnum.relationship:
        return "❤️";
      case RelationshipIntentEnum.marriage:
        return "💍";
      case RelationshipIntentEnum.friendship:
        return "🤝";
      case RelationshipIntentEnum.networking:
      case RelationshipIntentEnum.casualRelationship:
        return "👫";
      case RelationshipIntentEnum.dontKnowYet:
        // TODO: Handle this case.
        return "";
      case RelationshipIntentEnum.preferNotToSay:
        // TODO: Handle this case.
        return "";
    }
  }

  static RelationshipIntentEnum? fromString(String value) {
    for (final e in RelationshipIntentEnum.values) {
      if (e.name == value) return e;
    }
    return null;
  }

  static RelationshipIntentEnum? fromApi(String value) {
    for (final e in RelationshipIntentEnum.values) {
      if (e.apiValue == value) return e;
    }
    return null;
  }
}
