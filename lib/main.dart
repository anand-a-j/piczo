import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piczo/providers/user_provider/user_provider.dart';
import 'package:piczo/screens/home_screen/home_screen.dart';
import 'package:piczo/screens/login_screen/login_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider())
      ],
      child: MaterialApp(
        title: 'Piczo',
        theme: ThemeData(
          scaffoldBackgroundColor: kBlack,
          appBarTheme: AppBarTheme(
            backgroundColor: kBlack
          )

          ),
        /// persisting auth state -------------------------------------------------
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return HomeScreen();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                      style: TextStyle(color: kGrey),
                    ),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const LoginScreen();
            }),
      ),
    );
  }
}

/// Sample Home page------------------------------------------------------------


class HomePagee extends StatelessWidget {
  const HomePagee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
