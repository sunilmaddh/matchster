import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/widgets/common_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/sub_common_card.dart';

class InterestWrapWidget extends StatelessWidget {
  const InterestWrapWidget({super.key, required this.list});
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    list
        .map((e) => InterestEnumX.fromString(e)?.label)
        .whereType<String>()
        .toList();
    return CommonWrapWidget(
      listWidget:
          list.map((v) {
            final interest = InterestEnumX.fromString(v);
            return SubCommonCard(
              widget: CommonText.labelLarge(
                interest?.label ?? AppMethods.capitalizeFirst(v),
                color: AppColors.blackColor,
              ),
            );
          }).toList(),
    );
  }
}
