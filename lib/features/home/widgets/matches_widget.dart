import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/home/widgets/match_card.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({super.key, required this.list, required this.onTop});
  final List<String> list;
  final VoidCallback onTop;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: 5.horizontalPadding,
            child: MatchCard(onTop: onTop, image: list[index]),
          );
        },
      ),
    );
  }
}
