import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_text.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_contact.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/custom_message_file.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_image/custom_message_image.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_video.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomMessageDetailsBody extends StatelessWidget {
  const CustomMessageDetailsBody(
      {super.key,
      required this.message,
      required this.user,
      required this.size,
      required this.messageTextColor, required this.itemController,
    });

  final MessageModel message;
  final UserModel user;
  final Size size;
  final Color messageTextColor;
  final ItemScrollController itemController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.messageImage != null ||
              message.messageVideo != null && message.messageText != '' ||
              message.messageFile != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        if (message.phoneContactNumber != null)
          CustomMessageContact(message: message),
        if (message.messageFile != null)
          CustomMessageFile(message: message, user: user),
        if (message.messageVideo != null)
          CustomMessageVideo(message: message, user: user),
        if (message.messageImage != null && message.messageText == '')
          CustomMessageImage(size: size, message: message, user: user),
        if (message.messageImage != null && message.messageText != '')
          CustomMessageImage(size: size, message: message, user: user),
        if (message.messageText != '')
          CustomMessageText(
              itemController: itemController,
              size: size,
              messageModel: message,
              messageTextColor: messageTextColor),
      ],
    );
  }
}
