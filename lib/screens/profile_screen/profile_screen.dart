import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/resources/auth_methods.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/screens/chat_screen/chat_details_screen.dart';
import 'package:piczo/screens/login_screen/login_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/utils.dart';

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
    return SafeArea(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(12),
                    width: double.infinity,
                    //height: 260,
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
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData['username'],
                                    style: TextStyle(
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
                                      style: TextStyle(color: kGrey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                   Row(
                                     children: [
                                       FirebaseAuth
                                                      .instance.currentUser!.uid ==
                                                  widget.uid
                                              ? ElevatedButton(
                                                  onPressed: () async {
                                                    await AuthMethods().signOut();
                                                    showSnackBar(
                                                        "Logout successfully",
                                                        context,
                                                        AnimatedSnackBarType.info);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginScreen()));
                                                  },
                                                  child: Text(
                                                    "Settings",
                                                    style: TextStyle(color: kWhite),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            primaryPurple),
                                                    shape:
                                                        MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  50)),
                                                    ),
                                                  ),
                                                )
                                              : isFollowing
                                                  ? ElevatedButton(
                                                      onPressed: () async {
                                                        await FirestoreMethods()
                                                            .followUser(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                                userData['uid']);
                                                        setState(() {
                                                          isFollowing = false;
                                                          following--;
                                                        });
                                                      },
                                                      child: Text(
                                                        "Unfollow",
                                                        style: TextStyle(
                                                            color: kWhite),
                                                      ),
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                primaryPurple),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                        ),
                                                      ),
                                                    )
                                                  : ElevatedButton(
                                                      onPressed: () async {
                                                        await FirestoreMethods()
                                                            .followUser(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                                userData['uid']);
                                                        setState(() {
                                                          isFollowing = true;
                                                          following++;
                                                        });
                                                      },
                                                      child: Text(
                                                        "Follow",
                                                        style: TextStyle(
                                                            color: kWhite),
                                                      ),
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                primaryPurple),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                        ),
                                                      ),
                                                    ),
                                                  FirebaseAuth.instance.currentUser!.uid ==widget.uid ? Container(color: Colors.amber,):  ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetailsScreen(username: userData['uid'], profileImage: userData[
                                                                        'photoUrl'], chatWith: widget.uid)));
                                        },
                                        child: Text(
                                          "Message",
                                          style: TextStyle(color: kWhite),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  primaryPurple),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ),
                                      )
                                     ],
                                   ),
                                   
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 60,
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CountContainer(
                                    count: postLength.toString(),
                                    title: "post"),
                                CountContainer(
                                    count: followers.toString(),
                                    title: "Followers"),
                                CountContainer(
                                    count: following.toString(),
                                    title: "Following")
                              ],
                            )),
                        SizedBox(
                          height: 20,
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 1.5,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            var snap = (snapshot.data! as dynamic).docs[index];
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snap['postUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          });
                    }),
                  )
                ],
              ),
            ),
    );
  }
}

class CountContainer extends StatelessWidget {
  final String count;
  final String title;
  const CountContainer({
    super.key,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: kWhite),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: kGrey),
        )
      ],
    );
  }
}
