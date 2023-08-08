import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/widgets/post_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piczo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: kBlack 
      ),
      home: HomePagee(),
    );
  }
}

class HomePagee extends StatelessWidget {
  const HomePagee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PostCard(),
    );
  }
}

