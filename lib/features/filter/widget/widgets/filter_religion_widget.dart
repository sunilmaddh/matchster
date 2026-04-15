import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/religion_level_ext.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/widgets/filter_drop_dwon_widget.dart';

class FilterReligionWidget extends StatelessWidget {
  const FilterReligionWidget({super.key, required this.controller});
  final FilterController controller;
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      color: AppColors.filterCardColor,
      isBorder: false,
      widget: FilterDropDwonWidget(
        title: AppStrings.filterString.religionTitle,
        subtitle: AppStrings.filterString.religionSub,
        list: ReligionEnumX.list.toSet().toList(),
        onChanged: (String? value) {
          controller.selectedReligion.value = value;
        },
        hintText: 'Selecte ',
        value:
            ReligionEnumX.list.contains(controller.selectedReligion.value)
                ? controller.selectedReligion.value
                : null,
      ),
    );
  }
}
