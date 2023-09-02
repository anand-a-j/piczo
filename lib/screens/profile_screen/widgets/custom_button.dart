import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
       style: ButtonStyle(
        backgroundColor:const MaterialStatePropertyAll(primaryPurple),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
       child: Text(
       title,
       style: const TextStyle(color: kWhite),
      ),
    );
  }
}
