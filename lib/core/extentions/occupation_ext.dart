import 'package:matchster/core/enum/enum.dart';

extension OccupationExt on Occupation {
  String get displayName {
    switch (this) {
      case Occupation.doctor:
        return "Doctor";
      case Occupation.engineer:
        return "Engineer";
      case Occupation.doesntMatter:
        return "Doesn't Matter";
    }
  }

  static List<String> get list =>
      Occupation.values.map((e) => e.displayName).toList();
}
