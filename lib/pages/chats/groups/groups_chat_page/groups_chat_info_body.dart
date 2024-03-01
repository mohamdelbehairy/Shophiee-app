import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_page_info_details.dart';
import 'package:flutter/material.dart';

class GroupsChatInfoBody extends StatelessWidget {
  const GroupsChatInfoBody({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GroupsChatPageInfoDetails(groupModel: groupModel),
      ],
    );
  }
}
