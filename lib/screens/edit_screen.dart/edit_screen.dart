import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:piczo/models/user_model.dart';
import 'package:piczo/providers/user_provider.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/edit_screen.dart/widgets/custom_textformfield.dart';
import 'package:piczo/screens/settings_screen/settings_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
import 'package:piczo/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? _user;
  @override
  void initState() {
    _user = Provider.of<UserProvider>(context, listen: false).getUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: _user!.username);
    final TextEditingController bioController =
        TextEditingController(text: _user!.bio);

    return _user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "Edit Profile",
                style: TextStyle(color: kWhite),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                      controller: nameController, hintText: "Name"),
                  CustomTextFormField(
                      controller: bioController, hintText: "bio"),
                  CustomElevatedButton(
                      title: "Save",
                      isPressed: () {
                        if (nameController.text.isNotEmpty &&
                            bioController.text.isNotEmpty) {
                          updateNameAndbio(_user!.uid, nameController.text,
                              bioController.text, context);
                        } else {
                          showSnackBar("Field cannot save as empty!", context,
                              AnimatedSnackBarType.error);
                        }
                      },
                      isLoading: false)
                ],
              ),
            ),
          );
  }

  void updateNameAndbio(
      String uid, String username, String bio, BuildContext context) async {
    String res =
        await FirestoreMethods().updateUsernameAndBio(uid, username, bio);
    if (res == 'success' && context.mounted) {
      showSnackBar("Profile updated successfully", context,
          AnimatedSnackBarType.success);
      await Provider.of<UserProvider>(context, listen: false).refreshUser();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsScreen(username: username),
        ),
      );
    }
  }
}
