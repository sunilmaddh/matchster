import 'package:matchster/core/enum/enum.dart';

extension FrequencyEnumX on FrequencyEnum {
  String get label {
    switch (this) {
      case FrequencyEnum.everyday:
        return "Everyday";
      case FrequencyEnum.sometimes:
        return "Sometimes";
      case FrequencyEnum.often:
        return "Often";
      case FrequencyEnum.never:
        return "Never";
    }
  }
}

extension HabitTypeEmojiX on HabitTypeEnum {
  String get emoji {
    switch (this) {
      case HabitTypeEnum.workout:
        return "🏋️‍";
      case HabitTypeEnum.smoke:
        return "🚬";
      case HabitTypeEnum.drinking:
        return "🍻";
      case HabitTypeEnum.height:
        return "📏";
    }
  }
}
