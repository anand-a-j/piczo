import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:piczo/utils/colors.dart';
import 'package:piczo/widgets/custom_elevated_button.dart';

class AddPostButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddPostButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.network(
            "https://lottie.host/704fb66f-7bfc-4dff-a511-9f5d3c01ad76/GlyGt3vo9N.json",
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.40,
            animate: true,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          const Text("Every photo is a memory waiting to be made.",style: TextStyle(color: kGrey),),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          CustomElevatedButton(
              title: "Add Post", isPressed: onPressed, isLoading: false)
        ],
      ),
    );
  }
}
