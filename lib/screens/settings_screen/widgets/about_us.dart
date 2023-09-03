import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/utils/strings.dart';

void aboutUsSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: kBgGrey,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: const Column(
            children: [
              Text(
                "About Us",
                style: TextStyle(
                    color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
              ),
             SizedBox(
                height: 20,
              ),
              Text(
                aboutUs,
                style: TextStyle(color: kWhite,),
                textAlign: TextAlign.justify,
              ),
               Spacer(),
              Text("Made with ❤️, Coded by Anand",style: TextStyle(color: kWhite),)
            ],
          ),
        );
      });
}
