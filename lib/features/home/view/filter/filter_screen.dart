import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/home/controller/filter_controller.dart';
import 'package:matchster/features/home/view/filter/widgets/age_widget.dart';
import 'package:matchster/features/home/view/filter/widgets/distance_widget.dart';
import 'package:matchster/features/home/view/filter/widgets/preference_widget.dart';
import 'package:matchster/features/home/widgets/header_widget.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final _filterController = Get.find<FilterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(isCenterTitle: false, title: "Filter", onTop: () {}),
      body: Padding(
        padding: 20.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderWidget(controller: _filterController),
            30.hBox,
            AgeWidget(controller: _filterController),
            20.hBox,
            DistanceWidget(controller: _filterController),
            20.hBox,
            PreferenceWidget(),
          ],
        ),
      ),
    );
  }
}
