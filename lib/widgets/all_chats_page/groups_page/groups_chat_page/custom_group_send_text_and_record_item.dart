import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/custom_groups_send_record.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/cutom_send_text_message_button_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGroupSendTextAndRecordItem extends StatelessWidget {
  const CustomGroupSendTextAndRecordItem(
      {super.key,
      required this.isShowSendButton,
      required this.controller,
      required this.groupModel,
      required this.scrollController,
      required this.size,
      required this.isSwip,
      this.messageModel,
      this.userData, this.stopRecording});

  final bool isShowSendButton;
  final TextEditingController controller;
  final GroupModel groupModel;
  final ScrollController scrollController;
  final Size size;
  final bool isSwip;
  final MessageModel? messageModel;
  final UserModel? userData;
   final Function(String)? stopRecording;

  @override
  Widget build(BuildContext context) {
    var groupChat = context.read<GroupMessageCubit>();
    return Positioned(
        bottom: 5,
        right: 5,
        child: isShowSendButton
            ? CustomSendTextMessageButtonDetails(
                groupChat: groupChat,
                controller: controller,
                groupModel: groupModel,
                scrollController: scrollController,
                isSwip: isSwip,
                messageModel: messageModel,
                userData: userData)
            : CustomGroupsSendRecord(
              stopRecording: stopRecording,
                isSwip: isSwip,
                userData: userData,
                messageModel: messageModel,
                size: size,
                groupChat: groupChat,
                groupModel: groupModel));
  }
}
