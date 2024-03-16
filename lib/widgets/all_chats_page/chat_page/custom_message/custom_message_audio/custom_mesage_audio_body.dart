import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_audio_icon.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/message_sound_name.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/message_sound_time.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMessageAudioBody extends StatelessWidget {
  const CustomMessageAudioBody(
      {super.key, required this.message, required this.size});

  final MessageModel message;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: size.width * .025,
          leading: CustomMessageAudioIcon(
              size: size,
              message: message,
              icon: FontAwesomeIcons.play,
              onTap: () {}),
          title: MessageSoundName(size: size, message: message),
        ),
        MessageSoundTime(size: size, message: message),
      ],
    );
  }
}
