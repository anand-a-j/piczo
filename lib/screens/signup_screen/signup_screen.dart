import 'dart:typed_data';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piczo/resources/auth_methods.dart';
import 'package:piczo/screens/home_screen/home_screen.dart';
import 'package:piczo/screens/login_screen/login_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
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
  Uint8List? _image;
  bool isLoading = false;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      String res = await AuthMethods().signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          bio: _bioController.text,
          file: _image!);
      print(res);
      setState(() {
        isLoading = false;
      });
      if (res != "success" && context.mounted) {
        showSnackBar(res, context,AnimatedSnackBarType.success);
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } else {
      showSnackBar("Enter the data", context,AnimatedSnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 46,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : CircleAvatar(
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
          CustomElevatedButton(
            title: "Sign Up",
            isPressed: signUpUser,
            isLoading: isLoading,
          ),
          Row(
            children: [
              const Text(
                "Are you already login?",
                style: TextStyle(color: kGrey),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    "Login here",
                    style:
                        TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                  ),
                  ),
            ],
          )
        ],
      ),
    );
  }
}
