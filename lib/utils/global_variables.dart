import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/screens/add_post_screen/add_post_screen.dart';
import 'package:piczo/screens/chat_screen/chat_screen.dart';
import 'package:piczo/screens/feed_screen/feed_screen.dart';
import 'package:piczo/screens/profile_screen/profile_screen.dart';
import 'package:piczo/screens/search_screen/search_screen.dart';

List<Widget> pages = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const ChatScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
