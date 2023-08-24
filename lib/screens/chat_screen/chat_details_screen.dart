import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/resources/chat_methods.dart';
import 'package:piczo/screens/chat_screen/widgets/chat_bubble.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  final String username;
  final String profileImage;
  final String chatWith;
  ChatDetailsScreen(
      {super.key,
      required this.username,
      required this.profileImage,
      required this.chatWith});

  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileImage),
            ),
            const SizedBox(width: 5),
            Text(username)
          ],
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ChatMethods()
            .getMessageInChat(FirebaseAuth.instance.currentUser!.uid, chatWith),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No messages"),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  isMe: snapshot.data![index]['sender'] ==
                      FirebaseAuth.instance.currentUser!.uid,
                  message: snapshot.data![index],
                );
              });
        },
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              child: TextField(
                controller: chatController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your message..."),
                    
                    style:TextStyle(color: Colors.white),
              ),
            ),
          ),
          FloatingActionButton.small(
            onPressed: () async {
              if (chatController.text.isNotEmpty) {
                String message = chatController.text;
                chatController.clear();
                await ChatMethods().sendMessage(
                    FirebaseAuth.instance.currentUser!.uid, chatWith, message);
              }
            },
            child: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
