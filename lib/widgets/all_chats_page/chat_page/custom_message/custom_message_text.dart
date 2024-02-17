import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';

class CustomMessageText extends StatelessWidget {
  const CustomMessageText(
      {super.key, required this.message, required this.messageTextColor});
  final MessageModel message;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(message.messageFile != null) {
      return SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(
        right: message.messageText.length > 29
            ? size.width * .0035
            : message.messageImage != null
                ? size.width * .3
                : size.width * .126,
        bottom: message.messageText.length > 29
            ? size.width * .035
            : message.messageImage != null
                ? size.width * .001
                : size.width * .01,
      ),
      child: Text(
        message.messageText,
        style: TextStyle(color: messageTextColor, fontSize: size.width * .04),
      ),
    );
  }
}
