import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/comment_screen/comment_screen.dart';
import 'package:piczo/screens/feed_screen/widgets/like_button.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';

// ignore: must_be_immutable
class PostCard extends StatelessWidget {
  final dynamic snap;
  PostCard({super.key, required this.snap});
  int commentLength = 0;
  void getComments() async {
    try {
      QuerySnapshot snaps = await FirebaseFirestore.instance
          .collection('posts')
          .doc(snap['postId'])
          .collection('comments')
          .get();
      print("getting comments");
      commentLength = snaps.docs.length;
    } catch (e) {
      print("Something went wrong fetch comment= ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    getComments();
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff202020),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snap['profileImage']),
            ),
            title: Text(
              snap['username'],
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: kWhite,fontSize: 16),
            ),
            trailing: IconButton(
                onPressed: () => moreFunctions(context, snap),
                icon: const Icon(
                  Icons.more_horiz,
                  color: kGrey,
                )),
          ),
          Container(
            margin:const EdgeInsets.all(5),
            width: double.maxFinite,
            height: MediaQuery.sizeOf(context).height*0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(snap['postUrl']),
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: Row(
                children: [
                  LikeButton(
                    snap: snap,
                  ),  
                 const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${snap['likes'].length.toString()} likes",
                    style:const TextStyle(color: kWhite),
                  ),
                 const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentScreen(
                            snap: snap,
                          ),
                        ),
                      );
                    },
                    icon:const Icon(Icons.comment_outlined),
                    color: Colors.white,
                  ),
                 const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${commentLength.toString()} comments",
                    style:const TextStyle(color: Colors.white),
                  ),
                 const Spacer(),
                  Text(
                    GetTimeAgo.parse(snap['datePublished'].toDate()),
                    style:const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            width: double.infinity,
            child: RichText(
              text: TextSpan(
                style:const TextStyle(color: kWhite),
                children: [
                  TextSpan(
                      text: "${snap['username']}  ",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: snap['description'])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void moreFunctions(context, snap) {
    var currentUser = FirebaseAuth.instance.currentUser!.uid;
    showBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Delete Post"),
                onTap: () async {
                  print("delete post button clicked");
                  if (snap['uid'] == currentUser) {
                    String response =
                        await FirestoreMethods().deletePost(snap['postId']);
                    if (response == 'success' && context.mounted) {
                      Navigator.pop(context);
                      showSnackBar("Post Deleted Successfully", context,
                          AnimatedSnackBarType.info);
                    } else {
                      showSnackBar(response.toString(), context,
                          AnimatedSnackBarType.warning);
                    }
                  } else {
                    showSnackBar("You cannot delete this post", context,
                        AnimatedSnackBarType.warning);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Cancel"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
