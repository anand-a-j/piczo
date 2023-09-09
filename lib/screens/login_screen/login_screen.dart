import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:piczo/providers/loading_provider.dart';
import 'package:piczo/resources/auth_methods.dart';
import 'package:piczo/screens/home_screen/home_screen.dart';
import 'package:piczo/screens/login_screen/widgets/login_titles.dart';
import 'package:piczo/utils/utils.dart';
import 'package:piczo/widgets/custom_elevated_button.dart';
import 'package:piczo/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'widgets/signup_button_title.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginTitles(),
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
            Consumer<LoadingProvider>(
              builder: ((context, value, child) {
                return CustomElevatedButton(
                  title: "Login",
                  isPressed: () {
                    loginUser(context, provider);
                  },
                  isLoading: provider.isLoading,
                );
              }),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            const SignUpButtonTitle()
          ],
        ),
      ),
    );
  }

  void loginUser(BuildContext context, LoadingProvider provider) async {
    provider.changeIsLoading = true;
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "Logged in successfully." && context.mounted) {
      provider.changeIsLoading = false;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

      showSnackBar(res, context, AnimatedSnackBarType.success);
    } else {
      provider.changeIsLoading = false;
      showSnackBar(res, context, AnimatedSnackBarType.error);
    }
  }
}

