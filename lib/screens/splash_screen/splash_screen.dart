import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("PICZO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 34,color: kWhite),),
    );
  }
}
