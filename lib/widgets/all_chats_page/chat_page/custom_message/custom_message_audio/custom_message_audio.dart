import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_mesage_audio_body.dart';
import 'package:flutter/material.dart';

class CustomMessageAudio extends StatelessWidget {
  const CustomMessageAudio(
      {super.key, required this.message, required this.size});
  final MessageModel message;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .08,
      width: size.width * .7,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * .025),
        child: CustomMessageAudioBody(message: message, size: size),
      ),
    );
  }
}
