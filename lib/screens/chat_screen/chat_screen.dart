import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/resources/chat_methods.dart';
import 'package:piczo/resources/firestore_method.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "Messaged users :_${ChatMethods().getMessagedUsers(FirebaseAuth.instance.currentUser!.uid)}");

    return Scaffold(
      appBar: AppBar(
        title:const Text("Chats"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: ChatMethods()
              .getMessagedUsers(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            print("Snapshot data :${snapshot.data}");
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
                        // AsyncSnapshot<Map<String, dynamic>>? assSnap = assnapshot;
                        // if(assSnap==null){
                        //   return const Center(
                        //       child: CircularProgressIndicator());
                        // }
                        if (!assnapshot.hasData) {
                          return const SizedBox();
                        }
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(assnapshot.data!['profileImage']),
                          ),
                          title: Text(assnapshot.data!['username']),
                          subtitle: Text('hey'),
                        );
                      });
                },
              );
            }
          }),
    );
  }
}
