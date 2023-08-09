import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piczo/screens/profile_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/widgets/post_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          scaffoldBackgroundColor: kBlack),
      home: ProfileScreen(),
    );
  }
}

// class HomePagee extends StatelessWidget {
//   const HomePagee({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PostCard(),
//     );
//   }
// }
