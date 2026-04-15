import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/bar/custom_tab_bar_view.dart';
import 'package:matchster/features/filter/helper/filter_helper.dart';
import 'package:matchster/routes/app_navigation.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Filter",
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: Padding(
        padding: 20.horizontalPadding,
        child: CustomTabBarView(
          tabWidgets: FilterHelper.filterTab,
          tabBarWidgets: FilterHelper.barWidgets,
        ),
      ),
    );
  }
}
