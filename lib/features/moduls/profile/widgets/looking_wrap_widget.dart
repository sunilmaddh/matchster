import 'package:flutter/material.dart';
import 'package:matchster/core/extentions/looking_for_ext.dart';
import 'package:matchster/features/moduls/profile/widgets/common_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/common_wrap_card.dart';

class LookingWrapWidget extends StatelessWidget {
  const LookingWrapWidget({super.key, required this.list});

  final String list;

  @override
  Widget build(BuildContext context) {
    final intent = RelationshipIntentEnumX.fromApi(list);

    return CommonWrapWidget(
      listWidget: [
        if (list.isNotEmpty)
          CommonWrapCard(
            text: intent?.label ?? list,
            img: intent?.emoji ?? '',
          ),
      ],
    );
  }
}