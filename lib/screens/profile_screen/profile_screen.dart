import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Container(

              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              width: double.infinity,
              height: 260,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      
                       Expanded(
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Anand",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: kWhite),
                              ),
                              Text(
                                "Flutter Developer",
                                style: TextStyle(color: kGrey),
                              ),
                              Text(
                                "Dart | Flutter | Firebase",
                                style: TextStyle(color: kWhite),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                height: 40,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(color: kWhite),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(primaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                       ), 
                    ],
                  ),
                   Container(
                      height: 60,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CountContainer(count: "38", title: "post"),
                          CountContainer(count: "1350", title: "Followers"),
                          CountContainer(count: "678", title: "Following")
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}

class CountContainer extends StatelessWidget {
  final String count;
  final String title;
  const CountContainer({
    super.key, required this.count, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: kWhite),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: kGrey),
        )
      ],
    );
  }
}
