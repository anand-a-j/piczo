import 'package:flutter/material.dart';
import 'package:piczo/screens/comment_screen/widgets/comment_card.dart';
import 'package:piczo/utils/colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

final _commentController = TextEditingController();

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Comments",
          style: TextStyle(color: kWhite),
        ),
      ),
      body: ListView.builder(
          itemCount: 10, itemBuilder: (context, index) => CommentCard()),
      bottomNavigationBar: SafeArea(
          child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(),
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
                    decoration:const InputDecoration(
                      hintText: "Enter your comments....",
                      hintStyle: TextStyle(color: kGrey),
                      border: InputBorder.none,
                    ),
                    style:const TextStyle(color: kWhite),
                  ),
                ),
              ]),
            ),
            TextButton(onPressed: () {}, child: const Text("post"))
          ],
        ),
      )),
    );
  }
}
