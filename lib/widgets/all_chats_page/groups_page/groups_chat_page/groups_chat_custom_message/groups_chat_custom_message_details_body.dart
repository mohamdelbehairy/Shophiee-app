import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/widget/messages/custom_message_record_body.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_contact.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_file.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_image.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_text.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_video.dart';
import 'package:flutter/material.dart';

import 'groups_chat_custom_message_sound.dart';

class GroupsChatCustomMessageDetailsBody extends StatelessWidget {
  const GroupsChatCustomMessageDetailsBody(
      {super.key,
      required this.message,
      required this.user,
      required this.groupModel,
      required this.messageTextColor});

  final MessageModel message;
  final UserModel user;
  final GroupModel groupModel;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: message.messageImage != null ||
              message.messageVideo != null && message.messageText != '' ||
              message.messageFile != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        if (message.messageRecord != null)
          CustomMessageRecordBody(
              size: size,
              message: message,
              messageTextColor: messageTextColor,
              user: user),
        if (message.messageSound != null)
          GroupsChatCustomMessageSound(
              message: message, size: size, groupModel: groupModel),
        if (message.phoneContactNumber != null)
          GroupsChatCustomMessageContact(message: message, user: user),
        if (message.messageVideo != null)
          GroupsChatCustomMessageVideo(message: message, user: user),
        if (message.messageFile != null)
          GroupsChatCustomMessageFile(message: message, user: user),
        if (message.messageImage != null && message.messageText == '')
          GroupsChatCustomMessageImage(user: user, message: message),
        if (message.messageImage != null && message.messageText != '')
          GroupsChatCustomMessageImage(user: user, message: message),
        if (message.messageText != '')
          GroupsChatCustomMessageText(
              message: message, user: user, messageTextColor: messageTextColor),
      ],
    );
  }
}
