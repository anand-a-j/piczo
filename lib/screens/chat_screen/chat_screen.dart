import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/resources/chat_methods.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/utils/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        titleTextStyle: const TextStyle(color: kWhite),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ChatMethods()
            .getMessagedUsers(FirebaseAuth.instance.currentUser!.uid),
        builder: ((context, snapshot) {
          print(
            ChatMethods()
              .getMessagedUsers(FirebaseAuth.instance.currentUser!.uid)
              .toString());
          if (snapshot.data == null) {
            print("Data is null");
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Text("No messageds");
          }
          print("chattttttt snapshot :$snapshot");
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: FirestoreMethods()
                        .getUserData(snapshot.data![index]['users']),
                    builder: (context, asSnapshot) {
                      if (!asSnapshot.hasData) {
                        return const SizedBox();
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(asSnapshot.data!['profileImage']),
                        ),
                        title: Text(asSnapshot.data!['username']),
                      );
                    });
              });
        }),
      ),
    );
  }
}
