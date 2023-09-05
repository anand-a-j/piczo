import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:piczo/resources/chat_methods.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/chat_screen/chat_details_screen.dart';
import 'package:piczo/utils/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "Messaged users :_${ChatMethods().getMessagedUsers(FirebaseAuth.instance.currentUser!.uid)}");

    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: const Text("Chats"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: ChatMethods()
              .getMessagedUsers(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            List? snap = snapshot.data;
            if (snap == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future:
                          FirestoreMethods().getUserDataF(snap[index]['user']),
                      builder: (context, assnapshot) {
                        if (!assnapshot.hasData) {
                          return const Center(
                            child: Text(
                              "No Messages",
                              style: TextStyle(color: kWhite),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatDetailsScreen(
                                    username: assnapshot.data!['username'],
                                    profileImage: assnapshot.data!['photoUrl'],
                                    chatWith: assnapshot.data!['uid']
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(assnapshot.data!['photoUrl']),
                            ),
                            title: Text(
                              assnapshot.data!['username'],
                              style: const TextStyle(color: kWhite),
                            ),
                            subtitle: Text(
                              GetTimeAgo.parse(
                                snapshot.data![index]['time'].toDate(),
                              ),
                              style: const TextStyle(color: kGrey),
                            ),
                          ),
                        );
                      });
                },
              );
            }
          }),
    );
  }
}
