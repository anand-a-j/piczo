import 'package:flutter/material.dart';
import 'package:piczo/screens/chat_screen/widgets/chat_bubble.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [CircleAvatar(), SizedBox(width: 5), Text("Username")],
        ),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ChatBubble(isMe: true, message: {});
          }),
    );
  }
}
