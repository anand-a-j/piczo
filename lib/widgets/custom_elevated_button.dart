import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function()? isPressed;
  final bool isLoading;
  const CustomElevatedButton(
      {super.key,
      required this.title,
      required this.isPressed,
      required this.isLoading
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: isPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(primaryPurple)
          ),
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: kWhite,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(),
                )),
    );
  }
}
