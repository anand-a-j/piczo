import 'package:flutter/material.dart';
import 'package:piczo/screens/comment_screen/comment_screen.dart';
import 'package:piczo/screens/feed_screen/widgets/like_button.dart';
import 'package:piczo/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff202020),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snap['profileImage']),
            ),
            title: Text(
              snap['username'],
              style: TextStyle(fontWeight: FontWeight.bold, color: kWhite),
            ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentScreen()));
                    },
                    icon: Icon(Icons.comment_outlined),
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "21",
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
}
