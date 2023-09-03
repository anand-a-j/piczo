import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class UserNameTitle extends StatelessWidget {
  final String username;
  const UserNameTitle({super.key,required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child:  Text("Hey,\n$username",
          style:const TextStyle(color: kWhite, fontSize: 46)),
    );
  }
}
