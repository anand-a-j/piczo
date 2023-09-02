import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/resources/chat_methods.dart';
import 'package:piczo/screens/chat_screen/widgets/chat_bubble.dart';
import 'package:piczo/utils/colors.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  final String username;
  final String profileImage;
  final String chatWith;

  ChatDetailsScreen({
      super.key,
      required this.username,
      required this.profileImage,
      required this.chatWith
      });

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
            const SizedBox(width: 20),
            Text(username)
          ],
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ChatMethods()
            .getMessageInChat(FirebaseAuth.instance.currentUser!.uid, chatWith),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
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
      bottomNavigationBar: SafeArea(
        child: Container(
          color: kBgGrey,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                  child: TextField(
                    controller: chatController,
                    decoration:const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your message...",
                        hintStyle: TextStyle(color: kGrey
                        ),
                        ),
                        style:const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              FloatingActionButton.small(
                onPressed: () async {
                  if (chatController.text.isNotEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    String message = chatController.text;
                    chatController.clear();
                    await ChatMethods().sendMessage(
                        FirebaseAuth.instance.currentUser!.uid, chatWith, message);
                  }               
                },
                backgroundColor: primaryPurple,
                child:const Icon(Icons.send),
              )
            ],
          ),
        ),
      ),
    );
  }
}
