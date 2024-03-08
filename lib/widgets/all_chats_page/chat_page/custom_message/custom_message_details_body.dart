import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/refactory/refactory_message/message_text/image_message.dart';
import 'package:app/refactory/refactory_message/message_text/text_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_contact.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/custom_message_file.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_video.dart';
import 'package:flutter/material.dart';

class CustomMessageDetailsBody extends StatelessWidget {
  const CustomMessageDetailsBody(
      {super.key,
      required this.message,
      required this.user,
      required this.size,
      required this.messageTextColor});

  final MessageModel message;
  final UserModel user;
  final Size size;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.messageImage != null ||
              message.messageVideo != null && message.messageText != ''
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
          ImageMessageRefactory(size: size, messageModel: message),
        if (message.messageImage != null && message.messageText != '')
          ImageMessageRefactory(size: size, messageModel: message),
        if (message.messageText != '')
          TextMessageRefactory(
              size: size,
              messageModel: message,
              messageTextColor: messageTextColor),
      ],
    );
  }
}
