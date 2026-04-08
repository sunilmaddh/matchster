import 'package:matchster/core/enum/enum.dart';

extension EducationLevelEnumX on EducationLevelEnum {
  String get label {
    switch (this) {
      case EducationLevelEnum.diploma:
        return "Diploma";
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

  String get apiValue {
    switch (this) {
      case EducationLevelEnum.diploma:
        return "diploma";
      case EducationLevelEnum.pursuingGraduation:
        return "pursuing_graduation";
      case EducationLevelEnum.graduate:
        return "graduate";
      case EducationLevelEnum.pursuingPostGraduation:
        return "pursuing_post_graduation";
      case EducationLevelEnum.postGraduate:
        return "post_graduate";
      case EducationLevelEnum.phdOrMore:
        return "phd_or_more";
      case EducationLevelEnum.other:
        return "other";
    }
  }
}
