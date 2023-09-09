import 'package:flutter/material.dart';
import 'package:piczo/screens/login_screen/login_screen.dart';
import 'package:piczo/utils/colors.dart';

class LoginButtonTitle extends StatelessWidget {
  const LoginButtonTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Are you already login?",
          style: TextStyle(color: kGrey),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          child: const Text(
            "Login here",
            style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
