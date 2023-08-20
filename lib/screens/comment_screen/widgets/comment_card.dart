import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piczo/utils/colors.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({super.key,required this.snap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(snap['profilePic']),
          radius: 18,
        ),
        title: Text(snap['username'],style:const TextStyle(color: kWhite,fontWeight: FontWeight.w800),),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(snap['comment'],
              style:const TextStyle(color: kWhite),
            ),
            Text(DateFormat().add_yMMMEd().format(snap['datePublished'].toDate()), style: const TextStyle(color: kGrey))
          ],
        ),
      ),
    );
  }
}
