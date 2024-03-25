import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemsFileReplayingMessage extends StatelessWidget {
  const ItemsFileReplayingMessage(
      {super.key, required this.size, required this.message});

  final Size size;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.width * .015),
      child: CircleAvatar(
        radius: size.width * .038,
        backgroundColor:
            message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Colors.white
                : kPrimaryColor,
        child: Icon(Icons.insert_drive_file,
            color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? kPrimaryColor
                : Colors.white,
            size: size.width * .04),
      ),
    );
  }
}
