import 'package:matchster/core/enum/enum.dart';

extension WorkoutEnumX on WorkoutEnum {
  /// Human-readable label (UI)
  String get label {
    switch (this) {
      case WorkoutEnum.everyday:
        return "Everyday";
      case WorkoutEnum.sometimes:
        return "Sometimes";
      case WorkoutEnum.often:
        return "Often";
      case WorkoutEnum.never:
        return "Never";
    }
  }

  /// Value for API / storage
  String get apiValue => name;
}

extension ListStringX on List<String> {
  List<String> toLowerCaseList() =>
      map(
        (e) => e.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_'),
      ).toList();
}
