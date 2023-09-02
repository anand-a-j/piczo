import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostsGrid extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snaphot;
  const PostsGrid({super.key, required this.snaphot});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: (snaphot.data! as dynamic).docs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 1.5,
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          var snap = (snaphot.data! as dynamic).docs[index];
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(snap['postUrl']),
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
