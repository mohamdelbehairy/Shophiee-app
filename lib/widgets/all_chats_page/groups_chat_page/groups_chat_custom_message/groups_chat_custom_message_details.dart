import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_show_date_time_icon.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_contact.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_file.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_image.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_text.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_video.dart';
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
    return Padding(
      padding: EdgeInsets.only(
          left: message.senderID != FirebaseAuth.instance.currentUser!.uid
              ? size.width * .1
              : 0,
          top: message.messageImage != null ||
                  message.messageVideo != null ||
                  message.phoneContactNumber != null
              ? size.height * .01
              : 0),
      child: Align(
        alignment: alignment,
        child: Container(
          width: message.messageText.startsWith('http') ||
                  message.messageText.startsWith('https')
              ? size.width * .6
              : message.messageFile != null && message.messageText != ''
                  ? size.width * .6
                  : message.messageImage != null
                      ? size.width * .45
                      : message.messageText.length > 25
                          ? size.width * .5
                          : null,
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .03, vertical: size.width * .003),
          padding: EdgeInsets.all(
              message.messageImage != null || message.messageVideo != null
                  ? size.width * .01
                  : size.width * .02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(message.messageImage != null ||
                          message.messageVideo != null
                      ? size.width * .01
                      : size.width * .03),
                  topRight: Radius.circular(message.messageImage != null ||
                          message.messageVideo != null
                      ? size.width * .01
                      : size.width * .03),
                  bottomLeft: message.messageImage != null ||
                          message.messageVideo != null
                      ? Radius.circular(size.width * .01)
                      : bottomLeft,
                  bottomRight: message.messageImage != null ||
                          message.messageVideo != null
                      ? Radius.circular(size.width * .01)
                      : bottomRight),
              color: backGroundMessageColor),
          child: Stack(
            children: [
              Column(
                children: [
                  if (message.messageFile != null)
                    GroupsChatCustomMessageFile(message: message, user: user),
                  if (message.phoneContactNumber != null)
                    GroupsChatCustomMessageContact(
                        message: message, user: user),
                  if (message.messageVideo != null)
                    GroupsChatCustomMessageVideo(message: message, user: user),
                  if (message.messageImage != null)
                    GroupsChatCustomMessageImage(user: user, message: message),
                  message.messageImage != null && message.messageText == ''
                      ? Padding(padding: EdgeInsets.all(0))
                      : message.messageVideo != null &&
                              message.messageText == ''
                          ? Padding(padding: EdgeInsets.all(0))
                          : GroupsChatCustomMessageText(
                              message: message, user: user),
                ],
              ),
              Positioned(
                  right: message.messageImage != null ||
                          message.messageVideo != null
                      ? size.width * .005
                      : 0.0,
                  bottom: message.messageImage != null ||
                          message.messageVideo != null
                      ? size.width * .005
                      : 0.0,
                  child: CustomMessageShowDataTimeIcons(
                      message: message,
                      isSeen: isSeen,
                      messageTextColor: messageTextColor))
            ],
          ),
        ),
      ),
    );
  }
}
