import 'package:flutter/material.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/widgets/age_widget.dart';
import 'package:matchster/features/filter/widget/widgets/distance_widget.dart';
import 'package:matchster/features/filter/widget/widgets/preference_widget.dart';

class BasicFilterScreen extends BaseStatelessView<FilterController> {
  const BasicFilterScreen({super.key});
  @override
  Widget buildView(BuildContext context, FilterController controller) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AgeWidget(controller: controller),
            20.hBox,
            DistanceWidget(controller: controller),
            20.hBox,
            GenderPreferenceWidget(controller: controller),
          ],
        ),
        Padding(
          padding: 15.verticalPadding,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 51.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.filterHearderCardColor,
                        ),
                        onPressed: () {},
                        child: CommonText.labelLarge(
                          AppStrings.filterString.reset,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  10.wBox,
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 51.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () {},
                        child: CommonText.labelLarge(
                          AppStrings.filterString.apply,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
