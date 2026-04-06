import 'package:flutter/material.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/home/models/inshort_list.dart';
import 'package:matchster/features/profile/widgets/common_wrap_card.dart';
import 'package:matchster/features/profile/widgets/common_wrap_widget.dart';

class InshortWrapWidget extends StatelessWidget {
  const InshortWrapWidget({super.key, required this.list});
  final List<InshortList> list;

  @override
  Widget build(BuildContext context) {
    return CommonWrapWidget(
      listWidget:
          list.map((v) {
            AppMethods.appPrint(message: list.toString());
            // final intent = RelationshipIntentEnumX.fromString(v);
            return v != null
                ? CommonWrapCard(text: v.label, img: v.emoji)
                : SizedBox.shrink();
          }).toList(),
    );
  }
}
