import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(),
        title: Text("username",style: TextStyle(color: kWhite,fontWeight: FontWeight.w800),),
        subtitle: Text("""comments commmented by the user in the application piczo which is developed by anand,Is a paragraph 100 words
    Various educators teach rules governing the length of paragraphs. They may say that a paragraph should be 100 to 200 words long, or be no more than five or six sentences. But a good paragraph should not be measured in characters, words, or sentences. The true measure of your paragraphs should be ideas.""",
          style: TextStyle(color: kWhite),
        ),
      ),
    );
  }
}
