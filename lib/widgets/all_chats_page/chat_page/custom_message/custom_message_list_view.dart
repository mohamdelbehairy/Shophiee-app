import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomMessageListView extends StatelessWidget {
  const CustomMessageListView(
      {super.key,
      required this.user,
      required this.message,
      required this.size, required this.itemController});

  final UserModel user;
  final MessageModel message;
  final Size size;
    final ItemScrollController itemController;

  @override
  Widget build(BuildContext context) {
    return CustomMessage(
      itemController: itemController,
        user: user,
        message: message,
        isSeen: message.isSeen,
        bottomLeft: message.senderID == FirebaseAuth.instance.currentUser!.uid
            ? Radius.circular(size.width * .03)
            : Radius.circular(0),
        bottomRight: message.senderID == FirebaseAuth.instance.currentUser!.uid
            ? Radius.circular(0)
            : Radius.circular(size.width * .03),
        alignment: message.senderID == FirebaseAuth.instance.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        backGroundMessageColor:
            message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? kPrimaryColor
                : Color(0xffe8f8f8),
        messageTextColor:
            message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Colors.white
                : Colors.black);
  }
}
