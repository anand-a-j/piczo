import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/widgets/custom_elevated_button.dart';
import 'package:piczo/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 46,
                backgroundColor: primaryColor,
              ),
              Positioned(
                bottom: 0,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: kBlack,
                  radius: 16,
                  child: CircleAvatar(
                    radius: 14,
                    child: Icon(
                      Icons.add_a_photo,
                      size: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
          CustomTextField(
              textController: _usernameController,
              hintText: "Enter your username",
              textInputType: TextInputType.text),
          CustomTextField(
              textController: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress),
          CustomTextField(
            textController: _passwordController,
            hintText: "Enter your password",
            textInputType: TextInputType.text,
            isPass: true,
          ),
          CustomTextField(
              textController: _bioController,
              hintText: "Enter your bio",
              textInputType: TextInputType.text),
          CustomElevatedButton(title: "Sign Up", isPressed: () {})
        ],
      ),
    );
  }
}
