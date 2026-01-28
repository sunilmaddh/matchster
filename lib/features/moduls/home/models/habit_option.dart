import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/frequency_enum_ext.dart';

class HabitOption {
  final HabitTypeEnum type;
  final FrequencyEnum frequency;

  HabitOption({required this.type, required this.frequency});

  /// Display text with emoji
  String get display => "${type.emoji} ${frequency.label}";

  String get emoji => type.emoji;
  String get label => frequency.label;
}
