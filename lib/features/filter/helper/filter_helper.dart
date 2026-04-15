import 'package:flutter/material.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/filter_tab_extention.dart';
import 'package:matchster/core/extentions/workout_wrap_preference_ext.dart';
import 'package:matchster/features/filter/view/advance_filter_screen.dart';
import 'package:matchster/features/filter/view/basic_filter_screen.dart';

class FilterHelper {
  static List<Widget> get filterTab =>
      FilterTab.values.map((tab) => Tab(text: tab.displayName)).toList();
  static List<Widget> get barWidgets => [
    BasicFilterScreen(),
    AdvanceFilterScreen(),
  ];
  static List<String> get workoutList =>
      WorkoutWrapPreference.values.map((e) => e.displayName).toList();
}
