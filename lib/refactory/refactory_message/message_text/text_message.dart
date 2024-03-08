import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';

class TextMessageRefactory extends StatelessWidget {
  const TextMessageRefactory(
      {super.key,
      required this.messageModel,
      required this.size,
      required this.messageTextColor});
  final MessageModel messageModel;
  final Size size;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: messageModel.messageImage != null &&
                  messageModel.messageText == ''
              ? 0.0
              : messageModel.messageImage != null &&
                      messageModel.messageText != ''
                  ? size.height * .01
                  : size.height * .015,
          bottom: messageModel.messageImage != null &&
                  messageModel.messageText == ''
              ? 0.0
              : messageModel.messageImage != null &&
                      messageModel.messageText != ''
                  ? size.height * .01
                  : size.height * .015,
          left: size.width * .032,
          right: messageModel.messageText.length > 5 ? 8 : 0),
      child: Text(
        messageModel.messageText,
        style: TextStyle(color: messageTextColor),
      ),
    );
  }
}
