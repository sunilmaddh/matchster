import 'package:matchster/core/enum/enum.dart';

extension WorkoutPreferenceExt on WorkoutWrapPreference {
  String get displayName {
    switch (this) {
      case WorkoutWrapPreference.doesntMatter:
        return "Does't Matter";
      case WorkoutWrapPreference.yes:
        return "Yes";
      case WorkoutWrapPreference.sometimes:
        return "Sometimes";
      case WorkoutWrapPreference.tookABreak:
        return "Took a break";
      case WorkoutWrapPreference.never:
        return "Never";
    }
  }

  static List<String> get list =>
      WorkoutWrapPreference.values.map((e) => e.displayName).toList();
}
