import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/looking_preference_ext.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/filter_common_widget.dart';

class FilterLookingForWidget extends StatelessWidget {
  const FilterLookingForWidget({super.key, required this.controller});
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      isBorder: false,
      color: AppColors.filterCardColor,
      widget: FilterCommonWidget(
        title: AppStrings.filterString.lookingForTitle,
        subtitle: AppStrings.filterString.languageSub,
        list: LookingPreferenceExt.list,
        onTop: (v) {
          controller.selectedLookingFor.value = v;
        },
        isSelected: (v) => controller.selectedLookingFor.value == v,
      ),
    );
  }
}
