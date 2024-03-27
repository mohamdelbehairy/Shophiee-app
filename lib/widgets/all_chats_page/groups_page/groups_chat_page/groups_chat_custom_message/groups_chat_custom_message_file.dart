import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/replay_message_file.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_file_body.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageFile extends StatelessWidget {
  const GroupsChatCustomMessageFile(
      {super.key,
      required this.message,
      required this.user,
      required this.messageTextColor});
  final MessageModel message;
  final UserModel user;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
   
    return Container(
      width: message.replayImageMessage != '' ||
              message.replayContactMessage != '' ||
              message.replayFileMessage != '' ||
              message.replaySoundMessage != '' ||
              message.replayRecordMessage != ''
          ? size.width * .55
          : size.width * .53,
      margin: EdgeInsets.only(top: size.width * .01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.replayImageMessage != '' ||
              message.replayTextMessage != '' ||
              message.replayContactMessage != '' ||
              message.replayFileMessage != '' ||
              message.replaySoundMessage != '' ||
              message.replayRecordMessage != '')
            ReplayMessageFile(
                message: message,
                messageTextColor: messageTextColor,
                size: size),
          GroupsChatCustomMessageFileBody(size: size, message: message),
        ],
      ),
    );
  }
}
