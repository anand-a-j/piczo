import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:piczo/resources/auth_methods.dart';
import 'package:piczo/screens/edit_screen.dart/edit_screen.dart';
import 'package:piczo/screens/login_screen/login_screen.dart';
import 'package:piczo/screens/settings_screen/widgets/about_us.dart';
import 'package:piczo/screens/settings_screen/widgets/custom_button_container.dart';
import 'package:piczo/screens/settings_screen/widgets/user_title.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
import 'widgets/privacy_policy.dart';

class SettingsScreen extends StatelessWidget {
  final String username;
  const SettingsScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, color: kWhite),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          UserNameTitle(
            username: username,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.06,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              CustomButtonContainer(
                  icon: Icons.edit,
                  onPressed: () {
                    goToEditScreen(context);
                  },
                  title: "Edit Profile"),
              CustomButtonContainer(
                  icon: Icons.policy,
                  onPressed: () {
                    privacyPolicySheet(context);
                  },
                  title: "Privacy Policy"),
              CustomButtonContainer(
                  icon: Icons.people,
                  onPressed: () {
                    aboutUsSheet(context);
                  },
                  title: "About Us"),
              CustomButtonContainer(
                  icon: Icons.logout,
                  onPressed: () {
                    signOut(context);
                  },
                  title: "Log Out"),
               
              
            ],
          ),
        ],
      ),
    );
  }

  void signOut(BuildContext context) async {
    await AuthMethods().signOut();
    if (context.mounted) {
      showSnackBar("Logout successfully", context, AnimatedSnackBarType.info);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  void goToEditScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }
}
