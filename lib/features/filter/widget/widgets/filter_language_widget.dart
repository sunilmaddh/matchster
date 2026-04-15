import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/language_enum_ext.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/widgets/filter_common_bottomsheet_widget.dart';

class FilterLanguageWidget extends StatelessWidget {
  const FilterLanguageWidget({super.key, required this.controller});
  final FilterController controller;
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      color: AppColors.filterCardColor,
      isBorder: false,
      widget: FilterCommonBottomsheetWidget(
        title: AppStrings.filterString.language,
        subtitle: AppStrings.filterString.languageSub,
        list: LanguageEnumX.list.toSet().toList(),
        hintText: 'Select',
        value: '',
        controller: controller,
      ),
    );
  }
}
