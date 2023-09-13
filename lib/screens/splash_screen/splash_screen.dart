import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text(
                "PICZO",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  color: kWhite,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.010,),
              const Text(
                "Capture your memories, Share them with friends...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kGrey,
                  fontStyle: FontStyle.italic
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
