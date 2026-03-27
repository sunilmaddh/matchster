import 'package:flutter/material.dart';
import 'package:matchster/core/extentions/looking_for_ext.dart';
import 'package:matchster/features/profile/widgets/common_wrap_card.dart';
import 'package:matchster/features/profile/widgets/common_wrap_widget.dart';

class LookingWrapWidget extends StatelessWidget {
  const LookingWrapWidget({super.key, required this.list});
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return CommonWrapWidget(
      listWidget:
          list.map((v) {
            final intent = RelationshipIntentEnumX.fromApi(v);
            return v.isNotEmpty
                ? CommonWrapCard(text: intent!.label, img: intent.emoji)
                : SizedBox.shrink();
          }).toList(),
    );
  }
}
