import 'package:flutter/material.dart';
import 'package:piczo/screens/add_post_screen/add_post_screen.dart';
import 'package:piczo/screens/feed_screen/feed_screen.dart';
import 'package:piczo/screens/profile_screen/profile_screen.dart';
import 'package:piczo/screens/search_screen/search_screen.dart';
import 'package:piczo/utils/colors.dart';

List<Widget> pages = const[
  FeedScreen(),
  SearchScreen(),
   AddPostScreen(),
  Center(
    child: Text(
      "Chat Screen",
      style: TextStyle(color: kWhite),
    ),
  ),
  ProfileScreen()
];
