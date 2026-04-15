import 'package:matchster/core/enum/enum.dart';

extension AcademicBackgroundExt on AcademicBackground {
  String get displayName {
    switch (this) {
      case AcademicBackground.doesntMatter:
        return "Doesn't Matter";
      case AcademicBackground.diploma:
        return "Diploma/Tech/Traders";
      case AcademicBackground.graduation:
        return "Graduation";
      case AcademicBackground.pg:
        return "PG";
      case AcademicBackground.phd:
        return "Phd";
      case AcademicBackground.others:
        return "Others";
    }
  }

  static List<String> get list =>
      AcademicBackground.values.map((e) => e.displayName).toList();
}
