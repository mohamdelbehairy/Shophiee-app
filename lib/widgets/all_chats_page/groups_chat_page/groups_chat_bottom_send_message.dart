import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/send_message/send_message_button.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_message_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatBottomSendMessage extends StatefulWidget {
  const GroupsChatBottomSendMessage(
      {super.key,
      required this.onPressed,
      required this.groupModel,
      required this.scrollController});
  final Function() onPressed;

  final GroupModel groupModel;
  final ScrollController scrollController;

  @override
  State<GroupsChatBottomSendMessage> createState() =>
      _GroupsChatBottomSendMessageState();
}

class _GroupsChatBottomSendMessageState
    extends State<GroupsChatBottomSendMessage> {
  bool isShowSendButton = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var groupChat = context.read<GroupMessageCubit>();
    return Padding(
      padding: EdgeInsets.only(
          bottom: size.width * .015,
          right: size.width * .02,
          left: size.width * .03),
      child: Row(
        children: [
          GroupChatMessageTextField(
              controller: controller,
              onChanged: (value) async {
                setState(() {
                  isShowSendButton = value.isNotEmpty;
                });
              },
              onPressed: widget.onPressed),
          GestureDetector(
            onTap: () async {
              if (isShowSendButton) {
                await groupChat.sendGroupMessage(
                    messageText: controller.text,
                    imageUrl: null,
                    videoUrl: null,
                    groupID: widget.groupModel.groupID);
                controller.clear();
                widget.scrollController.animateTo(0,
                    duration: const Duration(microseconds: 20),
                    curve: Curves.easeIn);
                setState(() {
                  isShowSendButton = false;
                });
              }
            },
            child: SendMessageButton(
                icon: isShowSendButton ? Icons.send : Icons.mic),
          ),
        ],
      ),
    );
  }
}
