import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageSoundTime extends StatelessWidget {
  const MessageSoundTime(
      {super.key, required this.size, required this.message});

  final Size size;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: size.width * .01,
      left: size.width * .01,
      child: Text(
        message.messageSoundTime!,
        style: TextStyle(
          fontSize: size.width * .025,
        ),
      ),
    );
  }
}
