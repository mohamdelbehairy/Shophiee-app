import 'package:app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageSoundName extends StatelessWidget {
  const MessageSoundName(
      {super.key, required this.size, required this.message});

  final Size size;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .55,
      child: Text(
        message.messageSoundName!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Colors.white
                : Colors.black,
            fontSize: size.width * .03),
      ),
    );
  }
}
