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

class PostCard extends StatefulWidget {
  final dynamic snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLength = 0;
  int likesLength = 0;

  void getComments() async {
    try {
      QuerySnapshot commentSnaps = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      setState(() {
        commentLength = commentSnaps.docs.length;
      });
    } catch (e) {
      print("Something went wrong fetch comment= ${e.toString()}");
    }
  }

  int totalLikes() {
    try {
      final likes = widget.snap['likes'].length;
      setState(() {
        likesLength = likes;
      });
      return likesLength;
    } catch (e) {
      print("Something went wrong$e");
      return likesLength;
    }
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    totalLikes();
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
              backgroundImage: NetworkImage(widget.snap['profileImage']),
            ),
            title: Text(
              widget.snap['username'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: kWhite, fontSize: 18),
            ),
            trailing: IconButton(
                onPressed: () => moreFunctions(context, widget.snap),
                icon: const Icon(
                  Icons.more_horiz,
                  color: kGrey,
                )),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            width: double.maxFinite,
            height: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.snap['postUrl']),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: Row(
                children: [
                  LikeButton(
                    snap: widget.snap,
                  ),
                  Text(
                    "  $likesLength likes",
                    style: const TextStyle(color: kWhite),
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
                            snap: widget.snap,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.comment_outlined,
                      weight: 100,
                      grade: -25,
                      size: 20,
                    ),
                    color: kWhite,
                  ),
                  Text(
                    "${commentLength.toString()} comments",
                    style: const TextStyle(color: kWhite),
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
                style: const TextStyle(color: kWhite),
                children: [
                  TextSpan(
                    text: "${widget.snap['username']}  ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.snap['description'])
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                GetTimeAgo.parse(widget.snap['datePublished'].toDate()),
                style: const TextStyle(
                    color: kGrey,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 10),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          )
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
