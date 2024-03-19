import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupsChatCustomMessageText extends StatelessWidget {
  const GroupsChatCustomMessageText(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // if (message.messageFile != null) {
    //   return SizedBox();
    // }
    return Padding(
      padding: EdgeInsets.only(
          top: message.messageImage != null && message.messageText == ''
              ? 0.0
              : message.messageImage != null && message.messageText != ''
                  ? size.height * .01
                  : size.height * .015,
          bottom: message.messageImage != null && message.messageText == ''
              ? 0.0
              : message.messageImage != null && message.messageText != ''
                  ? size.height * .01
                  : size.height * .015,
          left: size.width * .032,
          right: message.messageText.length > 5 ? 8 : 8),
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
          GestureDetector(
            onTap: () {
              if (message.messageText.startsWith('http') ||
                  message.messageText.startsWith('https')) {
                launchUrl(Uri.parse(message.messageText));
              }
            },
            child: Text(
              message.messageText,
              style: TextStyle(
                color: message.messageText.startsWith('http') ||
                        message.messageText.startsWith('https')
                    ? Colors.indigo
                    : message.senderID == FirebaseAuth.instance.currentUser!.uid
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
