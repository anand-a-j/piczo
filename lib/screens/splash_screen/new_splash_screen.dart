import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piczo/screens/login_screen/login_screen.dart';
import 'package:piczo/screens/splash_screen/splash_screen.dart';
import 'package:piczo/utils/colors.dart';

import '../home_screen/home_screen.dart';

class NewSplashScreen extends StatelessWidget {
  const NewSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _handleAuthState(context);
          } else {
            return const SplashScreen();
          }
        });
  }
}

Widget _handleAuthState(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(color: kGrey),
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return LoginScreen();
      });
}
