import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CountContainer extends StatelessWidget {
  final String count;
  final String title;
  const CountContainer({
    super.key,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style:const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: kWhite),
        ),
        Text(
          title,
          style:const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: kGrey),
        )
      ],
    );
  }
}
