import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? _file = await imagePicker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  }
  
  print("No image selected");
}

showSnackBar(String content, BuildContext context, AnimatedSnackBarType type) {
  AnimatedSnackBar.material(
          content,
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


// showAlertDialog(BuildContext context) {
//   Widget okButton = TextButton(onPressed: () {}, child: const Text("Ok"));
//   Widget cancelButton = TextButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       child: const Text("Cancel"));

//   AlertDialog alert = AlertDialog(
//     title:const Text("Are you Sure!"),
//     content:const Text("Do you wanna delete this post?"),
//     actions: [cancelButton, okButton],
//   );

//   showDialog(context: context, builder: (context) => alert);
// }
