import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomMessageAudioIcon extends StatelessWidget {
  const CustomMessageAudioIcon(
      {super.key,
      required this.size,
      required this.message,
      required this.onTap,
      required this.icon});

  final Size size;
  final MessageModel message;
  final Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: size.height * .02,
        backgroundColor:
            message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Colors.white
                : Colors.grey,
        child: GestureDetector(
          onTap: onTap,
          child: Icon(icon,
              color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? kPrimaryColor
                  : Colors.white,
              size: size.height * .018),
        ));
  }
}
