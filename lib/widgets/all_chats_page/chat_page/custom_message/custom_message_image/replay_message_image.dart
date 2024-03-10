import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReplayMessageImage extends StatelessWidget {
  const ReplayMessageImage(
      {super.key, required this.size, required this.message});
  final Size size;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .7,
      padding: EdgeInsets.only(top: size.width * .03, bottom: size.width * .02),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: size.width * .03),
          Container(
              height: size.height * .04,
              width: size.width * .005,
              color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Colors.white
                  : Colors.grey),
          SizedBox(width: size.width * .02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.friendNameReplay!,
                  style: TextStyle(fontWeight: FontWeight.w900)),
              Text(
                  message.replayTextMessage != ''
                      ? message.replayTextMessage!
                      : message.replayImageMessage != ''
                          ? 'Photo'
                          : message.replayFileMessage != ''
                              ? message.replayFileMessage!
                              : message.replayContactMessage!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: message.senderID ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Colors.white70
                          : Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
