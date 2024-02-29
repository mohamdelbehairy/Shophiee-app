import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_replay_contact.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_text_replay_file.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_text_replay_image.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_text_replay_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomMessageText extends StatelessWidget {
  const CustomMessageText(
      {super.key,
      required this.message,
      required this.messageTextColor,
      required this.user});
  final MessageModel message;
  final Color messageTextColor;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (message.messageFile != null) {
      return SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(
        right: message.messageText.length > 29
            ? size.width * .0035
            : message.messageImage != null
                ? size.width * .3
                : message.replayTextMessage != '' ||
                        message.replayImageMessage != '' ||
                        message.replayFileMessage != '' ||
                        message.replayContactMessage != ''
                    ? 0.0
                    : size.width * .126,
        bottom: message.messageText.length > 29
            ? size.width * .035
            : message.messageImage != null
                ? size.width * .001
                : message.phoneContactNumber != null
                    ? 0.0
                    : message.replayTextMessage != '' ||
                            message.replayImageMessage != ''
                        ? size.width * .03
                        : size.width * .01,
      ),
      child: GestureDetector(
        onTap: () {
          if (message.messageText.startsWith('http') ||
              message.messageText.startsWith('https')) {
            launchUrl(Uri.parse(message.messageText));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.replayTextMessage != '' &&
                message.replayImageMessage == '' &&
                message.replayFileMessage == '' &&
                message.replayContactMessage == '')
              CustomMessageTextReplayText(user: user, message: message),
            if (message.replayImageMessage != '')
              CustomMessageTextReplayImage(user: user, message: message),
            if (message.replayFileMessage != '')
              CustomMessageTextReplayFile(user: user, message: message),
            if (message.replayContactMessage != '' &&
                message.phoneContactNumber != message.replayContactMessage)
              CustomMessageTextReplayContact(user: user, message: message),
            Text(
              message.messageText,
              style: TextStyle(
                  color: message.messageText.startsWith('http') ||
                          message.messageText.startsWith('https')
                      ? Colors.indigo
                      : messageTextColor,
                  fontSize: size.width * .04),
            ),
          ],
        ),
      ),
    );
  }
}
