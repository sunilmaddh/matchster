import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/widgets/sub_common_card.dart';

class CommonWrapWidget extends StatelessWidget {
  const CommonWrapWidget({
    super.key,
    required this.listWidget,
    this.boxColor = AppColors.whiteColor,
    this.borderColor = AppColors.whiteColor,
  });

  final List<Widget> listWidget;
  final Color boxColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children: listWidget,
    );
  }
}
