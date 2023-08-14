import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  }
  print("No image selected");
}

showSnackBar(String content, BuildContext context, AnimatedSnackBarType type) {
  AnimatedSnackBar.material(content,
          type: type,
          borderRadius: BorderRadius.circular(10),
          mobileSnackBarPosition: MobileSnackBarPosition.bottom
          )
      .show(context);

  //----------------------------------------------------------------------------
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   content: Text(content,style:const TextStyle(color: kBlack),),
  //   margin: const EdgeInsets.all(10),
  //   backgroundColor: kWhite,
  //   behavior: SnackBarBehavior.floating,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(10)
  //   ),
  // ),
  // );
}
