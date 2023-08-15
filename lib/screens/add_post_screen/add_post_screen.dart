import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text("Add post"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Post",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: primaryColor,fontSize: 20),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 30,
              height: 50,
              child: CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 20,
            ),
           ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 500,
              margin: EdgeInsets.only(right: 10,top: 10,bottom: 10),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width:double.infinity ,
                      height: 290,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://images.unsplash.com/photo-1628331507643-ddf8016ca45d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE3fENEd3V3WEpBYkV3fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60")
                        )
                      ),
                    ),
                    SizedBox(
                      height: 190,
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 8,
                         decoration: InputDecoration(
                          hintText: "Enter the caption....",
                          hintStyle: TextStyle(color: kGrey),
                          border: InputBorder.none,
                          
                         ),
                         style: TextStyle(color: kWhite),
                      ),
                    )
                  ],
                ),
              ),
            )
            )
        ],
      )
    );
  }
}
