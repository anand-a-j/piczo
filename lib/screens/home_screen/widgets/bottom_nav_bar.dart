import 'package:flutter/material.dart';
import 'package:piczo/screens/home_screen/home_screen.dart';
import 'package:piczo/utils/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HomeScreen.selectedIndexNotifier,
        builder: (context, updatedIndex, _) {
          return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: kBlack,
              unselectedIconTheme:const IconThemeData(color: kWhite,weight: 100,grade: -25,),
              selectedIconTheme: IconThemeData(color: Colors.purple.shade300,weight: 700,grade: 200),
              showSelectedLabels: false,
              showUnselectedLabels: false,   
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                HomeScreen.selectedIndexNotifier.value = newIndex;
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add), label: "add post"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.forum), label: "like"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "profile")
              ]);
        });
  }
}
