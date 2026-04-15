import 'package:matchster/core/enum/enum.dart';

extension FilterTabExtension on FilterTab {
  String get displayName {
    switch (this) {
      case FilterTab.basic:
        return "Basic Filter";
      case FilterTab.advance:
        return "Advance Filter";
    }
  }

  String get apiValue {
    switch (this) {
      case FilterTab.basic:
        return "basic_filter";
      case FilterTab.advance:
        return "advance_filter";
    }
  }
}
