import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(8),
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff202020),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text(
              "User name",
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
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1682227456282-37d424bee56a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDM3fENEd3V3WEpBYkV3fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: const SizedBox(
              width: double.infinity,
              height: 30,
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "528",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.comment_outlined,
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
                    "5 minutes ago",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              height: 20,
              child: Row(
                children: [
                  Text(
                    "Username  ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: kWhite),
                  ),
                  Text(
                    "hey what's app yoooooooooooo... ",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kWhite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
