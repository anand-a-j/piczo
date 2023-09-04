import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextFormField({
    super.key,
    required this.controller,

    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    const inputDecoration = OutlineInputBorder(
        borderSide: BorderSide(
      color: kGrey,
    ));
    return TextFormField(
      controller: controller,

      decoration:  InputDecoration(
          isDense: true,
          border: inputDecoration,
          enabledBorder: inputDecoration,
          hintText: hintText,
          hintStyle:const TextStyle(color: kGrey),
          filled: true,
          fillColor: kBgGrey,
          focusedBorder: inputDecoration,
          disabledBorder: inputDecoration),
      style: const TextStyle(color: kGrey),
    );
  }
}
