import 'package:matchster/core/enum/enum.dart';

extension InterestEnumX on InterestEnum {
  /// Emoji for UI
  String get label {
    switch (this) {
      case InterestEnum.baking:
        return "🍰 Baking";
      case InterestEnum.gym:
        return "💪 Gym";
      case InterestEnum.music:
        return "🎵 Music";
      case InterestEnum.travel:
        return "✈️ Travel";
      case InterestEnum.cooking:
        return "🍳 Cooking";
      case InterestEnum.games:
        return "🎮 Games";
      case InterestEnum.yoga:
        return "🧎‍♂️ Yoga";
      case InterestEnum.hiking:
        return "🧗‍♂️ Hiking";
      case InterestEnum.reading:
        return "📚 Reading";
      case InterestEnum.art:
        return "🎨 Art";
      case InterestEnum.foodie:
        return "🍽️ Foodie";
      case InterestEnum.photography:
        return "📸 Photography";
      case InterestEnum.tech:
        return "💻 Tech";
      case InterestEnum.nature:
        return "🌷 Nature";
      case InterestEnum.coffee:
        return "☕ Coffee";
      case InterestEnum.fashion:
        return "🕶️ Fashion";
      case InterestEnum.cycling:
        return "🚴‍♀️ Cycling";
      case InterestEnum.beach:
        return "🌊 Beach";
      case InterestEnum.gardening:
        return "🌱 Gardening";
      case InterestEnum.meditation:
        return "🧘‍♀️ Meditation";
      case InterestEnum.running:
        return "🏃‍♂️ Running";
      case InterestEnum.volunteering:
        return "🧍 Volunteering";
      case InterestEnum.theater:
        return "🎥 Theater";
      case InterestEnum.podcasts:
        return "🎤 Podcasts";
    }
  }

  // /// Human-readable label
  // String get label {
  //   switch (this) {
  //     case InterestEnum.baking:
  //       return "Baking";
  //     case InterestEnum.gym:
  //       return "Gym";
  //     case InterestEnum.music:
  //       return "Music";
  //     case InterestEnum.travel:
  //       return "Travel";
  //     case InterestEnum.cooking:
  //       return "Cooking";
  //     case InterestEnum.games:
  //       return "Games";
  //     case InterestEnum.yoga:
  //       return "Yoga";
  //     case InterestEnum.hiking:
  //       return "Hiking";
  //     case InterestEnum.reading:
  //       return "Reading";
  //     case InterestEnum.art:
  //       return "Art";
  //     case InterestEnum.foodie:
  //       return "Foodie";
  //     case InterestEnum.photography:
  //       return "Photography";
  //     case InterestEnum.tech:
  //       return "Tech";
  //     case InterestEnum.nature:
  //       return "Nature";
  //     case InterestEnum.coffee:
  //       return "Coffee";
  //     case InterestEnum.fashion:
  //       return "Fashion";
  //     case InterestEnum.cycling:
  //       return "Cycling";
  //     case InterestEnum.beach:
  //       return "Beach";
  //     case InterestEnum.gardening:
  //       return "Gardening";
  //     case InterestEnum.meditation:
  //       return "Meditation";
  //     case InterestEnum.running:
  //       return "Running";
  //     case InterestEnum.volunteering:
  //       return "Volunteering";
  //     case InterestEnum.theater:
  //       return "Theater";
  //     case InterestEnum.podcasts:
  //       return "Podcasts";
  //   }
  // }

  /// API / storage value
  static InterestEnum? fromString(String value) {
    for (final e in InterestEnum.values) {
      if (e.name == value) return e;
    }
    return null;
  }
}
