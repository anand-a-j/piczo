import 'package:flutter/material.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/utils/colors.dart';
import 'package:simple_animations/simple_animations.dart';

class LikeButton extends StatefulWidget {
  final snap;
  const LikeButton({super.key, required this.snap});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isFavorite = !isFavorite;
        });
        await FirestoreMethods().likePost(
            widget.snap['postId'], widget.snap['uid'], widget.snap['likes']);
      },
      child: PlayAnimationBuilder(
          tween: Tween(begin: 0.2, end: 1.0),
          duration: Duration(microseconds: 800),
          builder: (context, value, _) {
            return isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: kWhite,
                  );
          }),
    );
  }
}
