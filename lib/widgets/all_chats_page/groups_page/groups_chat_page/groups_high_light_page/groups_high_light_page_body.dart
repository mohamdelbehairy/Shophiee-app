import 'package:app/cubit/groups/high_light_group_message/hight_light_messages/high_light_messages_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatHighLightPageBody extends StatelessWidget {
  const GroupsChatHighLightPageBody(
      {super.key,
      required this.hightLightMessage,
      required this.size,
      required this.groupModel});

  final HightLightMessagesCubit hightLightMessage;
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HightLightMessagesCubit, HightLightMessagesState>(
        builder: (context, state) {
      return ListView.builder(
          itemCount: hightLightMessage.hightLightMessageList.length,
          itemBuilder: (context, index) {
            return GroupsHighLightListViewItem(
                message: hightLightMessage.hightLightMessageList[index],
                size: size,
                groupModel: groupModel);
          });
    });
  }
}
