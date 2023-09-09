import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class LoginTitles extends StatelessWidget {
  const LoginTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.20,
          ),
        const Text(
          "Hi, Welcome Back!👋",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 34,
            color: kWhite
          ),
         ),
        const Text(
            "Login with your credentials.",
            style: TextStyle(
                fontWeight: FontWeight.w400, 
                fontSize: 18, 
                color: kWhite),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.10,
          )
        ],
      ),
    );
  }
}