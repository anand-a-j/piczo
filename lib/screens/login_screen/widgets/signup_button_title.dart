import 'package:flutter/material.dart';
import 'package:piczo/screens/signup_screen/signup_screen.dart';
import 'package:piczo/utils/colors.dart';

class SignUpButtonTitle extends StatelessWidget {
  const SignUpButtonTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Are you new here?",
          style: TextStyle(color: kGrey),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupScreen(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
