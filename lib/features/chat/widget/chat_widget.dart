import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/chat/widget/chat_card.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.onTop});

  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: 10.verticalPadding,
          child: ChatCard(
            image: AppAssets.imageAssets6,
            text1: 'S, 28',
            text2: 'When we are meeting...',
            onTop: onTop,
          ),
        );
      },
    );
  }
}
