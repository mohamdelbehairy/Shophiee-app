import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_sound_component.dart';
import 'package:app/utils/widget/messages/message_sound_length.dart';
import 'package:flutter/material.dart';

class CustomMessageSoundBody extends StatelessWidget {
  const CustomMessageSoundBody(
      {super.key,
      required this.message,
      required this.size,
      required this.user});

  final MessageModel message;
  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: message.messageSoundPlaying == false
          ? size.height * .08
          : size.height * .09,
      width: size.width * .72,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * .025),
        child: Stack(
          children: [
            CustomMessageSoundComponent(
                message: message, size: size, user: user),
            if (message.messageSoundPlaying == false)
              MessageSoundLength(size: size, message: message),
          ],
        ),
      ),
    );
  }
}
