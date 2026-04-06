import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/home/controller/filter_controller.dart';
import 'package:matchster/features/home/widgets/filter_header_card.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.controller});
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39.h,
      decoration: BoxDecoration(
        color: AppColors.filterHearderCardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Obx(
        () => Row(
          children: [
            Flexible(
              child: FilterHeaderCard(
                onTop: () {
                  controller.isFilterType.value =
                      AppConstants.isFilterTypeBasic;
                },
                text: AppConstants.isFilterTypeBasic,
                gradient:
                    controller.isFilterType.value ==
                            AppConstants.isFilterTypeBasic
                        ? AppColors.gradientBoxCircle
                        : null,
              ),
            ),

            Flexible(
              child: FilterHeaderCard(
                onTop: () {
                  controller.isFilterType.value =
                      AppConstants.isFilterTypeAdvance;
                },
                text: AppConstants.isFilterTypeAdvance,
                gradient:
                    controller.isFilterType.value ==
                            AppConstants.isFilterTypeAdvance
                        ? AppColors.gradientBoxCircle
                        : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
