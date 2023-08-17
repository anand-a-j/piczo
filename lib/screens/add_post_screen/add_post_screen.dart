import 'dart:typed_data';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piczo/providers/user_provider/user_provider.dart';
import 'package:piczo/resources/firestore_method.dart';
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

  void postImage(String uid, String username, String profileImage) async {
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text.trim(),
          _file!,
          uid,
          username,
          profileImage);
      if (res == "post uploaded successfully" && context.mounted) {
        showSnackBar("posted", context, AnimatedSnackBarType.success);
      } else {
        showSnackBar(res, context, AnimatedSnackBarType.warning);
      }
    } catch (e) {
      showSnackBar(e.toString(), context, AnimatedSnackBarType.error);
    }
  }

  _selectImage(BuildContext context) async {
    return showBottomSheet(
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
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    print(userProvider);
    print(_file);
    return _file == null && context.mounted
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload),
              color: kBgGrey,
              iconSize: 24,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: kBlack,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text("Add post"),
              actions: [
                TextButton(
                  onPressed: () => postImage(
                      userProvider.getuser.uid,
                      userProvider.getuser.username,
                      userProvider.getuser.photoUrl),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    height: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      // backgroundImage:
                      //     NetworkImage(userProvider.getuser!.photoUrl??"null"),
                      radius: 24,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  height: 500,
                  margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 290,
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
                            decoration: InputDecoration(
                              hintText: "Enter the caption....",
                              hintStyle: TextStyle(color: kGrey),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: kWhite),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ));
  }
}
