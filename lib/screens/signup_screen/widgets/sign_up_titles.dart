import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.10,
          ),
          const Text(
            "Create an Account",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: kWhite),
          ),
          const Text(
            "Please fill the input below here...",
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14, color: kWhite),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          )
        ],
      ),
    );
  }
}
