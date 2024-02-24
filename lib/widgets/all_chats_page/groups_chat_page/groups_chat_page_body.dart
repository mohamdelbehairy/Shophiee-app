import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/bottom_group_chat_item_send_message.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_body_list_view.dart';
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

  @override
  void initState() {
    super.initState();
    context
        .read<GroupMessageCubit>()
        .getGroupMessage(groupID: widget.groupModel.groupID);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GroupsChatPageBodyListView(
            scrollController: scrollController, groupModel: widget.groupModel),
        SizedBox(height: size.height * .01),
        BottomGroupChatItemSendMessage(
          onPressed: () {},
          scrollController: scrollController,
          groupModel: widget.groupModel,
        )
      ],
    );
  }
}
