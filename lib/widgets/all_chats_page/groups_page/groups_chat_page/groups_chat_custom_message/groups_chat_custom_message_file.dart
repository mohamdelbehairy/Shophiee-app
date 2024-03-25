import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/replay_message_file.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_file_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final pickFile = context.read<PickFileCubit>();
    return Container(
      width: message.replayImageMessage != '' ||
              message.replayContactMessage != '' ||
              message.replayFileMessage != ''
          ? size.width * .54
          : size.width * .5,
      margin: EdgeInsets.only(top: size.width * .01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.replayImageMessage != '' ||
              message.replayTextMessage != '' ||
              message.replayContactMessage != '' ||
              message.replayFileMessage != '')
            ReplayMessageFile(
                message: message,
                messageTextColor: messageTextColor,
                size: size),
          GroupsChatCustomMessageFileBody(
              size: size, pickFile: pickFile, message: message),
        ],
      ),
    );
  }
}

