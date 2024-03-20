import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/custom_group_send_text_and_record_item.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_body_list_view.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_send_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatPageBody extends StatefulWidget {
  const GroupsChatPageBody({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<GroupsChatPageBody> createState() => _GroupsChatPageBodyState();
}

class _GroupsChatPageBodyState extends State<GroupsChatPageBody> {
  final scrollController = ScrollController();
  late TextEditingController controller;
  bool isShowSendButton = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    context
        .read<GroupMessageCubit>()
        .getGroupMessage(groupID: widget.groupModel.groupID);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var groupChat = context.read<GroupMessageCubit>();
    return Stack(
      children: [
        Column(
          children: [
            GroupsChatPageBodyListView(
                scrollController: scrollController,
                groupModel: widget.groupModel),
            SizedBox(height: size.height * .01),
            GroupsChatPageSendMedia(
                onChanged: (value) {
                  setState(() {
                    isShowSendButton = value.trim().isNotEmpty;
                  });
                },
                controller: controller,
                size: size,
                scrollController: scrollController,
                groupModel: widget.groupModel),
          ],
        ),
        CustomGroupSendTextAndRecordItem(
            isShowSendButton: isShowSendButton,
            groupChat: groupChat,
            controller: controller,
            widget: widget,
            scrollController: scrollController,
            size: size),
      ],
    );
  }
}
