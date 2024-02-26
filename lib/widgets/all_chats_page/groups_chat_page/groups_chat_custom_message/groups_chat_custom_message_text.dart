import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageText extends StatelessWidget {
  const GroupsChatCustomMessageText(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (message.messageFile != null) {
      return SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(
        right: message.messageText.length > 29
            ? size.width * .0035
            : message.messageImage != null
                ? size.width * 0.0
                : size.width * .126,
        bottom: message.messageText.length > 29
            ? size.width * .035
            : message.messageImage != null
                ? size.width * .03
                : message.phoneContactNumber != null
                    ? 0.0
                    : size.width * .01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.senderID != FirebaseAuth.instance.currentUser!.uid &&
              message.messageImage == null &&
              message.messageVideo == null &&
              message.phoneContactNumber == null)
            Text(user.userName,
                style: TextStyle(
                    fontSize: size.width * .04,
                    color: Colors.blue,
                    fontWeight: FontWeight.normal)),
          Text(
            message.messageText,
            style: TextStyle(
                color:
                    message.senderID == FirebaseAuth.instance.currentUser!.uid
                        ? Colors.white
                        : Colors.black,
                fontSize: size.width * .04),
          ),
        ],
      ),
    );
  }
}
