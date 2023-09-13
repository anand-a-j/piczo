import 'dart:typed_data';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piczo/models/user_model.dart';
import 'package:piczo/providers/add_post_provider.dart';
import 'package:piczo/providers/user_provider.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/add_post_screen/widgets/add_post_section.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;

  void postImage(String uid, String username, String profileImage,
      BuildContext context) async {
    final apProvider = Provider.of<AddPostProvider>(context, listen: false);
    apProvider.changeIsLoading = true;
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text.trim(),
          _file!,
          uid,
          username,
          profileImage);
      if (res == "post uploaded successfully" && context.mounted) {
        apProvider.changeIsLoading = false;
        showSnackBar(
            "posted Successfully", context, AnimatedSnackBarType.success);
        apProvider.resetImage();
      } else {
        showSnackBar(res, context, AnimatedSnackBarType.warning);
      }
    } catch (e) {
      showSnackBar(e.toString(), context, AnimatedSnackBarType.error);
    }
  }

  _selectImage(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Take a photo"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Pick from gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Cancel"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final apProvider = Provider.of<AddPostProvider>(context, listen: false);
    final User? user = Provider.of<UserProvider>(context).getUser;
    return user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _file == null && context.mounted
            ? AddPostButton(onPressed: ()=> _selectImage(context))
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: kBlack,
                  leading: Consumer<AddPostProvider>(
                    builder: (context, value, child) {
                      return IconButton(
                          onPressed: apProvider.resetImage(),
                          icon: const Icon(Icons.arrow_back));
                    },
                  ),
                  title: const Text("Add post"),
                  actions: [
                    TextButton(
                      onPressed: () => postImage(
                          user.uid, user.username, user.photoUrl, context),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryPurple,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                body: Consumer<AddPostProvider>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        apProvider.isLoading
                            ? const LinearProgressIndicator()
                            : const SizedBox(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 30,
                                height: 50,
                                child: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  backgroundImage: NetworkImage(user.photoUrl),
                                  radius: 24,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                padding: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 240,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(_file!),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 190,
                                        child: TextField(
                                          controller: _descriptionController,
                                          maxLines: 8,
                                          decoration: const InputDecoration(
                                            hintText: "Enter the caption....",
                                            hintStyle: TextStyle(color: kGrey),
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(color: kWhite),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
  }
}
