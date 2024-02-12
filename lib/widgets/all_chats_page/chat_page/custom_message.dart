import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage({
    super.key,
    required this.message,
    required this.backGroundMessageColor,
    required this.messageTextColor,
    required this.alignment,
    required this.bottomLeft,
    required this.bottomRight,
  });
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
        width: message.messageText.length > 25 ? size.width * .5 : null,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.width * .003),
        padding: EdgeInsets.all(size.width * .02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * .03),
                topRight: Radius.circular(size.width * .03),
                bottomLeft: bottomLeft,
                bottomRight: bottomRight),
            color: backGroundMessageColor),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: message.messageText.length > 29
                      ? size.width * .0035
                      : size.width * .13,
                  bottom: message.messageText.length > 29
                      ? size.width * .035
                      : size.width * .01),
              child: Text(
                message.messageText,
                style: TextStyle(color: messageTextColor),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('14:56',
                      style: TextStyle(
                          fontSize: size.width * .02, color: messageTextColor)),
                  SizedBox(width: size.width * .02),
                  Icon(Icons.done,
                      size: size.width * .032, color: messageTextColor)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
