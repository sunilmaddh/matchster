import 'package:flutter/material.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/widgets/age_widget.dart';
import 'package:matchster/features/filter/widget/widgets/distance_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_academic_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_drinking_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_language_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_looking_for_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_occupation_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_religion_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_smoke_widget.dart';
import 'package:matchster/features/filter/widget/widgets/filter_swip_button.dart';
import 'package:matchster/features/filter/widget/widgets/filter_workout_widget.dart';
import 'package:matchster/features/filter/widget/widgets/height_range_widget.dart';
import 'package:matchster/features/filter/widget/widgets/show_verified_profile.dart';

class AdvanceFilterScreen extends BaseStatelessView<FilterController> {
  const AdvanceFilterScreen({super.key});
  @override
  Widget buildView(BuildContext context, FilterController controller) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 120.h),
            child: Column(
              spacing: 10.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShowVerifiedProfile(),
                HeightRangeWidget(controller: controller),
                AgeWidget(controller: controller),
                DistanceWidget(controller: controller),
                FilterWorkoutWidget(controller: controller),
                FilterSmokeWidget(controller: controller),
                FilterDrinkinWidget(controller: controller),
                FilterLookingForWidget(controller: controller),
                FilterAcademicWidget(controller: controller),
                FilterOccupationWidget(controller: controller),
                FilterReligionWidget(controller: controller),
                FilterLanguageWidget(controller: controller),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: 15.verticalPadding,
            child: FilterSwipButton(),
          ),
        ),
      ],
    );
  }
}
