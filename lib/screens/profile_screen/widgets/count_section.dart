import 'package:flutter/material.dart';

import 'count_container.dart';

class CountSection extends StatelessWidget {
  const CountSection({
    super.key,
    required this.postLength,
    required this.followers,
    required this.following,
  });

  final int postLength;
  final int followers;
  final int following;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.08,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CountContainer(count: postLength.toString(), title: "post"),
          CountContainer(count: followers.toString(), title: "Followers"),
          CountContainer(count: following.toString(), title: "Following")
        ],
      ),
    );
  }
}
