import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/strings.dart';

void privacyPolicySheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: kBgGrey,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: const Column(
              children: [
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                      color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  privacyPolicy,
                  style: TextStyle(color: kWhite),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        );
      });
}
