import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/features/home/view/filter/widgets/preference_menu_widget.dart';
import 'package:matchster/features/home/widgets/text_with_widget.dart';

class PreferenceWidget extends StatelessWidget {
  PreferenceWidget({super.key});

  final list = ["Men", "Women"];

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      isBorder: false,
      color: AppColors.filterCardColor,
      widget: TextWithWidget(
        title: "Preference",
        subTitle: "Whom you want to date?",
        widget: PreferenceMenuWidget(list: list, onTop: () {}),
      ),
    );
  }
}
