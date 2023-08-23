import 'package:flutter/material.dart';
import 'package:piczo/utils/colors.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final Map<String, dynamic> message;

  const ChatBubble({super.key, required this.isMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 2),
          child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding:const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                //margin: EdgeInsets.all(8),
                width: 140,
                decoration: BoxDecoration(
                  color: isMe ? primaryPurple : kBgGrey,
                 borderRadius: BorderRadius.only(
                  bottomLeft:const Radius.circular(10),
                  topRight:const Radius.circular(10),
                  topLeft: isMe ? const Radius.circular(10) : Radius.zero,
                  bottomRight:isMe ? Radius.zero : const Radius.circular(10),
                 )
                ),
                child:const Text("Hello anand dsjflkds aflkdsaj fldsaflkadsn fdsa",style: TextStyle(color: kWhite),),
              ),
              const Text(" 10:28 ",style: TextStyle(color: kGrey,fontSize: 12),)
            ],
          ),
        )
      ],
    );
  }
}
