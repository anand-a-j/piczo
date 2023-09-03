import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CustomButtonContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  const CustomButtonContainer({super.key,required this.icon,required this.onPressed,required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: kBgGrey,
          borderRadius: BorderRadius.circular(40),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: kGrey,
          ),
          horizontalTitleGap: 20,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold,color: kWhite),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: kBgGrey,
          ),
        ),
      ),
    );
  }
}
