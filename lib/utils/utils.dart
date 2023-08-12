import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piczo/utils/colors.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  }
  print("No image selected");
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content,style:const TextStyle(color: kBlack),),
    margin: const EdgeInsets.all(10),
    backgroundColor: kWhite,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
  ),
  );
}
