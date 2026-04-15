import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/occupation_ext.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/widgets/filter_drop_dwon_widget.dart';

class FilterOccupationWidget extends StatelessWidget {
  const FilterOccupationWidget({super.key, required this.controller});

  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CommonCard(
        color: AppColors.filterCardColor,
        isBorder: false,
        widget: FilterDropDwonWidget(
          title: AppStrings.filterString.occuptionTitle,
          subtitle: AppStrings.filterString.occupationSub,
          list: OccupationExt.list.toSet().toList(),
          hintText: 'Select',
          value:
              OccupationExt.list.contains(controller.selectedOccupation.value)
                  ? controller.selectedOccupation.value
                  : null,
          onChanged: (String? value) {
            controller.selectedOccupation.value = value;
          },
        ),
      ),
    );
  }
}
