import 'package:matchster/core/enum/enum.dart';

extension RelationshipIntentEnumX on RelationshipIntentEnum {
  /// Human-readable label (UI)
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
  String get apiValue => name;
}
