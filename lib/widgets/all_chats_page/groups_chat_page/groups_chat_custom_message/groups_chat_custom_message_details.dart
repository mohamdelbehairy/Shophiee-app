import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_details_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageDetails extends StatelessWidget {
  const GroupsChatCustomMessageDetails(
      {super.key,
      required this.message,
      required this.alignment,
      required this.bottomLeft,
      required this.bottomRight,
      required this.user,
      required this.backGroundMessageColor,
      required this.isSeen,
      required this.messageTextColor});
  final MessageModel message;
  final UserModel user;
  final Alignment alignment;
  final Radius bottomLeft;
  final Radius bottomRight;
  final Color backGroundMessageColor;
  final bool isSeen;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: alignment,
      child: Container(
        width: message.messageImage != null ||
                message.messageVideo != null ||
                message.messageFile != null ||
                message.phoneContactNumber != null ||
                message.messageSound != null ||
                message.messageRecord != null ||
                message.replayTextMessage != '' ||
                message.replayFileMessage != '' ||
                message.replayImageMessage != '' ||
                message.replayContactMessage != ''
            ? null
            : message.messageText.length <= 4
                ? size.width * .15
                : message.messageText.length > 30
                    ? size.width * .8
                    : null,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.width * .003),
        padding: EdgeInsets.only(
            right: message.messageImage != null ||
                    message.messageVideo != null ||
                    message.messageSound != null ||
                    message.messageRecord != null
                ? 0.0
                : message.messageFile != null
                    ? size.width * .02
                    : size.width * .01,
            left: message.messageFile != null ? 6 : 0,
            bottom: message.messageFile != null ? 6 : 0),
        decoration: BoxDecoration(
          color: message.messageImage != null && message.messageText == ''
              ? Colors.transparent
              : backGroundMessageColor,
          borderRadius: BorderRadius.only(
            topRight:
                Radius.circular(message.messageText.length <= 100 ? 16 : 24),
            topLeft: Radius.circular(
                message.receiverID == FirebaseAuth.instance.currentUser!.uid &&
                            message.messageText.length <= 100 ||
                        message.messageSound != null ||
                        message.messageRecord != null
                    ? 16
                    : 24),
            bottomRight: Radius.circular(
                message.senderID != FirebaseAuth.instance.currentUser!.uid
                    ? 24
                    : 0),
            bottomLeft: Radius.circular(message.senderID !=
                    FirebaseAuth.instance.currentUser!.uid
                ? 0
                : message.messageSound != null || message.messageRecord != null
                    ? 16
                    : 24),
          ),
        ),
        child: GroupsChatCustomMessageDetailsBody(message: message, user: user),
      ),
    );
  }
}
