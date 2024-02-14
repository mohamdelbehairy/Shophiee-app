import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';

class CustomMessageImage extends StatelessWidget {
  const CustomMessageImage(
      {super.key, required this.message, required this.isSeen});
  final MessageModel message;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width * .45,
          height: size.width * .45,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(message.messageImage!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
