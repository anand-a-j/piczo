import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search here",
                hintStyle: TextStyle(color: kGrey),
                filled: true,
                fillColor: kBlack.withOpacity(0.7)
              ),
            ),
          )
        ],
      ),
    );
  }
}
