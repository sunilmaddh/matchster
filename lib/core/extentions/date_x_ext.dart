import 'package:intl/intl.dart';

extension DateX on DateTime {
  String get ui => DateFormat('dd-MM-yyyy').format(this);
  String get api => DateFormat('yyyy-MM-dd').format(this);
  String get readable => DateFormat('MMM d yyyy').format(this);
  DateTime get eighteenYearsAgo {
    return DateTime(year - 18, month, day);
  }
}
