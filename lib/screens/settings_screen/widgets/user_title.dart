import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class UserNameTitle extends StatelessWidget {
  const UserNameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(10),
      width: double.infinity,
      child:const Text(
        "Hey,\nAnand",
      style: TextStyle(color: kWhite,fontSize: 36)
      ),
    );
  }
}