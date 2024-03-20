import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/custom_groups_send_record.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/custom_send_message_text_message_button.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_body.dart';
import 'package:flutter/material.dart';

class CustomGroupSendTextAndRecordItem extends StatelessWidget {
  const CustomGroupSendTextAndRecordItem({
    super.key,
    required this.isShowSendButton,
    required this.groupChat,
    required this.controller,
    required this.widget,
    required this.scrollController,
    required this.size,
  });

  final bool isShowSendButton;
  final GroupMessageCubit groupChat;
  final TextEditingController controller;
  final GroupsChatPageBody widget;
  final ScrollController scrollController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 5,
        right: 5,
        child: isShowSendButton
            ? CustomSendTextMessageButton(
                groupChat: groupChat,
                controller: controller,
                groupModel: widget.groupModel,
                scrollController: scrollController)
            : CustomGroupsSendRecord(
                size: size,
                groupChat: groupChat,
                groupModel: widget.groupModel));
  }
}
