import 'package:flutter/material.dart';
// import 'package:piczo/providers/user_provider/user_provider.dart';
import 'package:piczo/screens/home_screen/widgets/bottom_nav_bar.dart';
import 'package:piczo/utils/global_variables.dart';
// import 'package:provider/provider.dart';
// import 'package:piczo/models/user.dart' as model;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bool isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   // getUserName();
  // }

  // Future<bool> getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   if (snap == null) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  //   return isLoading;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: HomeScreen.selectedIndexNotifier,
          builder: (context, updatedIndex, _) {
            return pages[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
