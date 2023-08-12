import 'package:flutter/material.dart';
import 'package:piczo/widgets/custom_elevated_button.dart';
import 'package:piczo/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        CustomTextField(textController: _emailController, hintText: "Enter your email here", textInputType: TextInputType.emailAddress,),
        CustomTextField(textController: _passwordController, hintText: "Enter your password here", textInputType: TextInputType.text,isPass: true,),
        CustomElevatedButton(title: "Login", isPressed: (){},isLoading: false,) 
        ],
      ),
    );
  }
}
