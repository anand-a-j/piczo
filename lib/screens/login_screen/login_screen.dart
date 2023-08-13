import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:piczo/main.dart';
import 'package:piczo/resources/auth_methods.dart';
import 'package:piczo/screens/signup_screen/signup_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
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
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "Logged in successfully." && context.mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePagee()));
      showSnackBar(res, context,AnimatedSnackBarType.success);
    } else {
      showSnackBar(res, context,AnimatedSnackBarType.error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            textController: _emailController,
            hintText: "Enter your email here",
            textInputType: TextInputType.emailAddress,
          ),
          CustomTextField(
            textController: _passwordController,
            hintText: "Enter your password here",
            textInputType: TextInputType.text,
            isPass: true,
          ),
          CustomElevatedButton(
            title: "Login",
            isPressed: loginUser,
            isLoading: _isLoading,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
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
                            builder: (context) => const SignupScreen()));
                  },
                  child: const Text("Sign Up",style: TextStyle(color: kWhite,fontWeight: FontWeight.bold),))
            ],
          )
        ],
      ),
    );
  }
}
