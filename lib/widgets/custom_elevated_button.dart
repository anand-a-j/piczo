import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function()? isPressed;
  const CustomElevatedButton({super.key, required this.title,required this.isPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      color: primaryColor,
      child: ElevatedButton(onPressed: isPressed, child: Text(title,style: TextStyle(),)),
    );
  }
}
