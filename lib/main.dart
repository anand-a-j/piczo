import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piczo/providers/add_post_provider.dart';
import 'package:piczo/providers/loading_provider.dart';
import 'package:piczo/providers/user_provider.dart';
import 'package:piczo/screens/splash_screen/new_splash_screen.dart';
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => AddPostProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Piczo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: kBlack,
          appBarTheme: const AppBarTheme(backgroundColor: kBlack),
        ),
        home: const NewSplashScreen(),
      ),
    );
  }
}
