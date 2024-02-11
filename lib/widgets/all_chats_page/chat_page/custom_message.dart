import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage(
      {super.key,
      required this.message,
      required this.backGroundMessageColor,
      required this.messageTextColor,
      required this.alignment,
      required this.bottomLeft,
      required this.bottomRight});
  final MessageModel message;
  final Color backGroundMessageColor;
  final Color messageTextColor;
  final Alignment alignment;
  final Radius bottomLeft;
  final Radius bottomRight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: alignment,
      child: Container(
        // width: size.width * .23,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * .038, vertical: size.width * .02),
        padding: EdgeInsets.all(size.width * .038),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                size.width * .038,
              ),
              topRight: Radius.circular(
                size.width * .038,
              ),
              bottomLeft: bottomLeft,
              bottomRight: bottomRight
            ),
            color: backGroundMessageColor),
        child: Text(
          message.messageText,
          style: TextStyle(color: messageTextColor),
        ),
      ),
    );
  }
}
