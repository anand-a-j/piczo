import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piczo/models/user_model.dart';
import 'package:piczo/providers/user_provider.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/comment_screen/widgets/comment_card.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Comments",
          style: TextStyle(color: kWhite),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(snap['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentCard(
                snap: (snapshot.data! as dynamic).docs[index],
              ),
            );
          }
          return const Center(
            child: Text(
              "No Comments",
              style: TextStyle(color: kWhite),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding:const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ListView(shrinkWrap: true, children: [
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _commentController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Comment as ${user.username}",
                      hintStyle: const TextStyle(color: kGrey),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: kWhite),
                  ),
                ),
              ]),
            ),
            TextButton(
              onPressed: () async {
                String response = await FirestoreMethods().postComment(
                    _commentController.text.trim(),
                    snap['postId'],
                    user.uid,
                    user.username,
                    user.photoUrl);
                if (response == "success" && context.mounted) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  showSnackBar("Commented posted successfully.", context,
                      AnimatedSnackBarType.success);
                  _commentController.text = "";
                } else if (response == "empty-field") {
                  showSnackBar("Enter the comment!!!.", context,
                      AnimatedSnackBarType.info);
                } else {
                  showSnackBar(response, context, AnimatedSnackBarType.error);
                }
              },
              child: const Text("post"),
            ),
          ],
        ),
      )),
    );
  }
}

TextEditingController _commentController = TextEditingController();
