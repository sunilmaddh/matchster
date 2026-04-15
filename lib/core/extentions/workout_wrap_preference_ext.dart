import 'package:matchster/core/enum/enum.dart';

extension WorkoutWrapPreferenceExtension on WorkoutWrapPreference {
  String get displayName {
    switch (this) {
      case WorkoutWrapPreference.doesntMatter:
        return "Doesn't Matter";
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

  String get apiValue {
    switch (this) {
      case WorkoutWrapPreference.doesntMatter:
        return "doesnt_matter";
      case WorkoutWrapPreference.yes:
        return "yes";
      case WorkoutWrapPreference.sometimes:
        return "sometimes";
      case WorkoutWrapPreference.tookABreak:
        return "took_a_break";
      case WorkoutWrapPreference.never:
        return "never";
    }
  }

  static List<String> get list =>
      WorkoutWrapPreference.values.map((e) => e.displayName).toList();
}
