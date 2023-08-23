import 'package:flutter/material.dart';
import 'package:piczo/screens/home_screen/widgets/bottom_nav_bar.dart';
import 'package:piczo/utils/global_variables.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (context, updatedIndex, _) {
            return pages[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar:const BottomNavBar(),
    );
  }
}
