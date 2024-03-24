import 'package:app/cubit/groups/get_groups_member/get_groups_member_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_state.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_page/groups_chat_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatPage extends StatefulWidget {
  const GroupsChatPage({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<GroupsChatPage> createState() => _GroupsChatPageState();
}

class _GroupsChatPageState extends State<GroupsChatPage> {
  final scrollController = ScrollController();
  late TextEditingController controller;
  bool isShowSendButton = false;

  @override
  void initState() {
    controller = TextEditingController();
    context
        .read<GroupMessageCubit>()
        .getGroupMessage(groupID: widget.groupModel.groupID);
    context.read<GetGroupsMemberCubit>().getGroupsMember();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<GetGroupsMemberCubit, GetGroupsMemberState>(
        builder: (context, state) {
      if (state is GetGroupsMemberSuccess && state.groupsList.isNotEmpty) {
        final groupID = widget.groupModel.groupID;
        final groupData = state.groupsList
            .firstWhere((element) => element.groupID == groupID);
        return GeoupsChatPageBody(
          groupModel: groupData,
          size: size,
          scrollController: scrollController,
          controller: controller,
          isShowSendButton: isShowSendButton,
          onChanged: (value) {
            setState(() {
              isShowSendButton = value.trim().isNotEmpty;
            });
          },
        );
      } else {
        return Container();
        // return GeoupsChatPageBody(
        //   groupModel: widget.groupModel,
        //   size: size,
        //   scrollController: scrollController,
        //   controller: controller,
        //   isShowSendButton: isShowSendButton,
        //   onChanged: (value) {},
        // );
      }
    });
  }
}
