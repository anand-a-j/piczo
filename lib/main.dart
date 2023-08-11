import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piczo/screens/signup_screen.dart';
import 'package:piczo/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piczo',
      theme: ThemeData(
          
          scaffoldBackgroundColor: kBlack),
      home: SignupScreen(),
    );
  }
}

class HomePagee extends StatelessWidget {
  const HomePagee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBlack,
        unselectedIconTheme: IconThemeData(
          color: kGrey
        ),
        selectedIconTheme: IconThemeData(
          color: kGrey
        ),
        currentIndex: 0,
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search_off_outlined),label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Likes"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile")
        ]
        ),
    );
  }
}
