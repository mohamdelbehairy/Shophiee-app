import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/send_message/send_message_button.dart';
import 'package:flutter/material.dart';

class CustomSendTextMessageButton extends StatelessWidget {
  const CustomSendTextMessageButton(
      {super.key,
      required this.groupChat,
      required this.controller,
      required this.groupModel,
      required this.scrollController,
      required this.replayTextMessage,
      required this.friendNameReplay,
      required this.replayImageMessage,
      required this.replayFileMessage,
      required this.replayContactMessage,
      required this.replayMessageID});

  final GroupMessageCubit groupChat;
  final TextEditingController controller;
  final GroupModel groupModel;
  final ScrollController scrollController;
  final String replayTextMessage;
  final String friendNameReplay;
  final String replayImageMessage;
  final String replayFileMessage;
  final String replayContactMessage;
  final String replayMessageID;

  @override
  Widget build(BuildContext context) {
    return SendMessageButton(
        onTap: () async {
          groupChat.sendGroupMessage(
              messageText: controller.text,
              imageUrl: null,
              videoUrl: null,
              groupID: groupModel.groupID,
              replayImageMessage: replayImageMessage,
              friendNameReplay: friendNameReplay,
              replayMessageID: replayMessageID,
              replayContactMessage: replayContactMessage,
              replayFileMessage: replayFileMessage,
              replayTextMessage: replayTextMessage);
          controller.clear();
          scrollController.animateTo(0,
              duration: const Duration(microseconds: 20), curve: Curves.easeIn);
        },
        icon: Icons.send);
  }
}
