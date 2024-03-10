import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_image/chat_message_image.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_image/replay_message_image.dart';
import 'package:flutter/material.dart';

class CustomMessageImage extends StatelessWidget {
  const CustomMessageImage(
      {super.key,
      required this.message,
      required this.user,
      required Size size});
  final MessageModel message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        if (message.replayTextMessage != '')
          ReplayMessageImage(message: message, size: size),
        ChatMessageImage(message: message, size: size),
      ],
    );
  }
}
