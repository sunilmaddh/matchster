import 'package:flutter/material.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Chat", onTop: () {}),
      body: Column(children: [
      
      ],),
    );
  }
}
