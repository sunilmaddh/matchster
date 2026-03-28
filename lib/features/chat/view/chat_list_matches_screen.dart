import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/chat/view/chat_screen.dart';
import 'package:matchster/features/chat/widget/chat_widget.dart';
import 'package:matchster/features/home/widgets/search_widget.dart';
import 'package:matchster/features/like/widget/matches_widget.dart';

class ChatListMetchesScreen extends StatelessWidget {
  ChatListMetchesScreen({super.key});

  final List<String> list = [
    AppAssets.imageAssets2,
    AppAssets.imageAssets3,
    AppAssets.imageAssets4,
    AppAssets.imageAssets5,
    AppAssets.imageAssets6,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: 15.horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.titleMedium("Chats", fontWeight: FontWeight.w700),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                ],
              ),
              20.hBox,
              SearchWidget(onChanged: (String value) {}),
              20.hBox,
              CommonText.titleMedium("Matches"),
              10.hBox,
              MatchesWidget(list: list, onTop: () {}),
              15.hBox,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.titleMedium("Message"),
                  CommonText.labelMedium("12 unread chats"),
                ],
              ),
              10.hBox,
              ChatWidget(
                onTop: () {
                  Get.to(ChatScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
