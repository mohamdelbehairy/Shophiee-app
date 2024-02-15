import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_mesage_image.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_show_date_time_icon.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text.dart';
import 'package:app/pages/chats/show_chat_image_page.dart';
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
    required this.isSeen,
    required this.user,
  });
  final MessageModel message;
  final Color backGroundMessageColor;
  final Color messageTextColor;
  final Alignment alignment;
  final Radius bottomLeft;
  final Radius bottomRight;
  final bool isSeen;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (message.messageImage != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ShowChatImagePage(message: message, user: user)));
        }
      },
      child: Align(
        alignment: alignment,
        child: Container(
          width: message.messageImage != null
              ? size.width * .45
              : message.messageText.length > 25
                  ? size.width * .5
                  : null,
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .03, vertical: size.width * .003),
          padding: EdgeInsets.all(message.messageImage != null
              ? size.width * .01
              : size.width * .02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(message.messageImage != null
                      ? size.width * .01
                      : size.width * .03),
                  topRight: Radius.circular(message.messageImage != null
                      ? size.width * .01
                      : size.width * .03),
                  bottomLeft: message.messageImage != null
                      ? Radius.circular(size.width * .01)
                      : bottomLeft,
                  bottomRight: message.messageImage != null
                      ? Radius.circular(size.width * .01)
                      : bottomRight),
              color: backGroundMessageColor),
          child: Stack(
            children: [
              Column(
                children: [
                  if (message.messageImage != null)
                    CustomMessageImage(message: message, isSeen: isSeen),
                  message.messageImage != null && message.messageText == ''
                      ? Padding(padding: EdgeInsets.all(0))
                      : CustomMessageText(
                          message: message, messageTextColor: messageTextColor)
                ],
              ),
              Positioned(
                  bottom:
                      message.messageImage != null ? size.width * .005 : 0.0,
                  right: message.messageImage != null ? size.width * .005 : 0.0,
                  child: CustomMessageShowDataTimeIcons(
                      message: message,
                      isSeen: isSeen,
                      messageTextColor: messageTextColor))
            ],
          ),
        ),
      ),
    );
  }
}
