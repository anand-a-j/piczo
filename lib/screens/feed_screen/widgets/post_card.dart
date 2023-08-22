import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/comment_screen/comment_screen.dart';
import 'package:piczo/screens/feed_screen/widgets/like_button.dart';
import 'package:piczo/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:piczo/utils/utils.dart';

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
                  const TextStyle(fontWeight: FontWeight.bold, color: kWhite),
            ),
            trailing: IconButton(
                onPressed: () => moreFunctions(context, snap),
                icon: const Icon(
                  Icons.more_horiz,
                  color: kGrey,
                )),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: double.maxFinite,
            height: 275,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(snap['postUrl']),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: Row(
                children: [
                  LikeButton(
                    snap: snap,
                  ),
                  // Icon(
                  //   Icons.favorite_border_outlined,
                  //   color: Colors.white,
                  // ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    snap['likes'].length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      print(snap);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                    snap: snap,
                                  )));
                    },
                    icon: Icon(Icons.comment_outlined),
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    commentLength.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.comment_outlined,
                    color: Colors.white,
                  ),
                  Spacer(),
                  Text(
                    DateFormat().add_yMMMd().format(
                          snap['datePublished'].toDate(),
                        ),
                    style: TextStyle(color: Colors.white),
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
                style: TextStyle(color: kWhite),
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
    showBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Delete Post"),
                onTap: () async{
                  print("delete post button clicked");
                  // Widget okButton = TextButton(
                      // onPressed: () {
                        String response =
                          await  FirestoreMethods().deletePost(snap['postId']);
                        if (response == 'success'&&context.mounted) {
                          Navigator.pop(context);
                          showSnackBar("Post Deleted Successfully", context,
                              AnimatedSnackBarType.info);
                        }else{
                          showSnackBar(response.toString(), context,
                              AnimatedSnackBarType.warning);
                        }
                      },
                  //     child: const Text("Ok"));
                  // Widget cancelButton = TextButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: const Text("Cancel"));

                  // AlertDialog alertBox = AlertDialog(
                  //   title: const Text("Are you Sure!"),
                  //   content: const Text("Do you wanna delete this post?"),
                  //   actions: [
                  //     cancelButton, 
                  //     okButton
                  //     ],
                  // );

                  // showDialog(context: context, builder: (context) => alertBox);
                  // Navigator.pop(context);
                // },
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
