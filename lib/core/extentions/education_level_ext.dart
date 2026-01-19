import 'package:matchster/core/enum/enum.dart';

extension EducationLevelEnumX on EducationLevelEnum {
  String get label {
    switch (this) {
      case EducationLevelEnum.diplomaTechTrade:
        return "Diploma / Tech / Trade courses";
      case EducationLevelEnum.pursuingGraduation:
        return "Pursuing Graduation";
      case EducationLevelEnum.graduate:
        return "Graduate";
      case EducationLevelEnum.pursuingPostGraduation:
        return "Pursuing Post Graduation";
      case EducationLevelEnum.postGraduate:
        return "Post Graduate";
      case EducationLevelEnum.phdOrMore:
        return "PhD or More";
      case EducationLevelEnum.other:
        return "Other";
    }
  }
}
