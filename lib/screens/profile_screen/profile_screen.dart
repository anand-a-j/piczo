import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/providers/user_provider.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/chat_screen/chat_details_screen.dart';
import 'package:piczo/screens/profile_screen/widgets/custom_button.dart';
import 'package:piczo/screens/settings_screen/settings_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';
import 'package:provider/provider.dart';
import 'widgets/count_section.dart';
import 'widgets/post_grid.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).refreshUser();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;
      postLength = postSnap.docs.length;
      followers = userSnap['followers'].length;
      following = userSnap['following'].length;
      isFollowing = userSnap['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context, AnimatedSnackBarType.warning);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return SafeArea(
      child: isLoading && userData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userData['photoUrl']),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.03,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData['username'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: kWhite),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 5, left: 0),
                                    height: 35,
                                    width: double.infinity,
                                    child: Text(
                                      userData['bio'],
                                      style: const TextStyle(color: kGrey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.012,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      currentUserId == widget.uid
                                          ? CustomButton(
                                              title: "Settings",
                                              onPressed: () {
                                                goToSettings(
                                                    context,
                                                    userData['username']
                                                        .toString());
                                              })
                                          : isFollowing
                                              ? CustomButton(
                                                  title: "Unfollow",
                                                  onPressed: unfollowFun)
                                              : CustomButton(
                                                  title: "Follow",
                                                  onPressed: followFun),
                                      currentUserId == widget.uid
                                          ? const SizedBox.shrink()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0),
                                              child: CustomButton(
                                                  title: "Message",
                                                  onPressed: messageFunction),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CountSection(
                            postLength: postLength,
                            followers: followers,
                            following: following),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return PostsGrid(snaphot: snapshot);
                    }),
                  )
                ],
              ),
            ),
    );
  }

  void unfollowFun() async {
    await FirestoreMethods()
        .followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
    setState(() {
      isFollowing = false;
      following--;
    });
  }

  void followFun() async {
    await FirestoreMethods()
        .followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
    setState(() {
      isFollowing = true;
      following++;
    });
  }

  void messageFunction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailsScreen(
            username: userData['username'],
            profileImage: userData['photoUrl'],
            chatWith: widget.uid),
      ),
    );
  }

  void goToSettings(BuildContext context, String name) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          username: name,
        ),
      ),
    );
  }
}
