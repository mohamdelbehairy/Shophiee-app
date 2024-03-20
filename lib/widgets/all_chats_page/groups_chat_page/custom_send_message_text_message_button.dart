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
      required this.scrollController});

  final GroupMessageCubit groupChat;
  final TextEditingController controller;
  final GroupModel groupModel;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SendMessageButton(
        onTap: () async {
          await groupChat.sendGroupMessage(
              messageText: controller.text,
              imageUrl: null,
              videoUrl: null,
              groupID: groupModel.groupID);
          controller.clear();
          scrollController.animateTo(0,
              duration: const Duration(microseconds: 20), curve: Curves.easeIn);
        },
        icon: Icons.send);
  }
}
