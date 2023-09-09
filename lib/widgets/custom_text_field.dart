import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  const CustomTextField({super.key, required this.textController, required this.hintText, required this.textInputType, this.isPass=false});

  @override
  Widget build(BuildContext context) {
    const inputDecoration =  OutlineInputBorder(
      borderSide: BorderSide(
        color: kGrey,  
      )
    );
    return Padding(
      padding:const EdgeInsets.all(10),
      child: TextField( 
        controller: textController,
        decoration: InputDecoration( 
          isDense: true,
          border: inputDecoration,
          enabledBorder: inputDecoration,
          hintText: hintText,
          hintStyle:const TextStyle(color: kGrey),
          filled: true,
          fillColor: kBgGrey,
          focusedBorder: inputDecoration,
          disabledBorder: inputDecoration
        ),
        style:const TextStyle(color: kGrey),
        obscureText: isPass,
      ),
    );
  }
}
