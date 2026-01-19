import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/education_level_ext.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/extentions/language_enum_ext.dart';
import 'package:matchster/core/extentions/looking_for_ext.dart';
import 'package:matchster/core/extentions/religion_level_ext.dart';
import 'package:matchster/core/extentions/visibility_enum_ext.dart';
import 'package:matchster/core/extentions/workout_enum_ext.dart';
import 'package:matchster/core/extentions/zodiac_enum_ext.dart';

class CommonLists {
  static List<String> religions =
      ReligionEnum.values.map((v) => v.label).toList();

  static final List<String> studieList =
      EducationLevelEnum.values.map((e) => e.label).toList();
  static final List<String> workouts =
      WorkoutEnum.values.map((e) => e.label).toList();
  static final List<String> zodiocss =
      ZodiacEnum.values.map((e) => e.label).toList();

  static final List<String> languageList =
      LanguageEnum.values.map((e) => e.label).toList();

  static final List<String> interestText =
      InterestEnum.values.map((e) => e.label).toList();
  static final List<String> visibilities =
      VisibilityEnum.values.map((e) => e.label).toList();
  static final List<String> releationships =
      RelationshipIntentEnum.values.map((e) => e.label).toList();
}
