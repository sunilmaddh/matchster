import 'package:matchster/core/enum/enum.dart';

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
