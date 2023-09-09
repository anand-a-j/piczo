import 'dart:typed_data';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piczo/providers/loading_provider.dart';
import 'package:piczo/resources/auth_methods.dart';
import 'package:piczo/screens/login_screen/login_screen.dart';
import 'package:piczo/screens/signup_screen/widgets/sign_up_titles.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
import 'package:piczo/widgets/custom_elevated_button.dart';
import 'package:piczo/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'widgets/login_button_title.dart';

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
  Uint8List? _image;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser(LoadingProvider provider) async {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      provider.changeIsLoading = true;
      String res = await AuthMethods().signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          bio: _bioController.text,
          file: _image!);
      provider.changeIsLoading = false;
      if (res != "success" && context.mounted) {
        showSnackBar(res, context, AnimatedSnackBarType.success);
      } else {
        openLoginScreen();
      }
    } else {
      provider.changeIsLoading = false;
      showSnackBar("Enter the data", context, AnimatedSnackBarType.error);
    }
  }

  openLoginScreen(){
   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SignUpTitle(),
            Center(
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 46,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 46,
                          backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/00/64/67/80/240_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg"),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: kBlack,
                      radius: 16,
                      child: CircleAvatar(
                        radius: 14,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.020,
            ),
            CustomTextField(
                textController: _usernameController,
                hintText: "Enter your username",
                textInputType: TextInputType.text
                ),
            CustomTextField(
                textController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress
                ),
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
            Consumer<LoadingProvider>(
              builder: (context, value, child) {
                return CustomElevatedButton(
                  title: "Sign Up",
                  isPressed: () {
                    signUpUser(provider);
                  },
                  isLoading: provider.isLoading,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            const LoginButtonTitle()
          ],
        ),
      ),
    );
  }
}

