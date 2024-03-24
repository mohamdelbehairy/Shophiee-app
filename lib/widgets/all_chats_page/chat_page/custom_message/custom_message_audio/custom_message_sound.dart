import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_mesage_sound_body.dart';
import 'package:app/utils/widget/replay_to_message/replay_sound_message.dart';
import 'package:flutter/material.dart';

class CustomMessageSound extends StatelessWidget {
  const CustomMessageSound(
      {super.key,
      required this.message,
      required this.size,
      required this.user,
      required this.messageTextColor});
  final MessageModel message;
  final Size size;
  final UserModel user;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.replayTextMessage != '' ||
            message.replayImageMessage != '' ||
            message.replayFileMessage != '' ||
            message.replayContactMessage != '')
          ReplaySoundMessage(
              size: size, message: message, messageTextColor: messageTextColor),
        CustomMessageSoundBody(message: message, size: size, user: user),
      ],
    );
  }
}
