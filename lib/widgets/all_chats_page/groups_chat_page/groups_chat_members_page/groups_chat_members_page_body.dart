import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_members_page_list_view.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_page_add_member_bottom.dart';
import 'package:flutter/material.dart';

class GroupsChatMembersPageBody extends StatelessWidget {
  const GroupsChatMembersPageBody(
      {super.key, required this.size, required this.groupModel});
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: size.width * .035,
              left: size.width * .035,
              top: size.width * .025),
          child: Text('All Members',
              style: TextStyle(
                  color: Color(0xff85889f),
                  fontWeight: FontWeight.normal,
                  fontSize: size.height * .015)),
        ),
        SizedBox(height: size.height * .01),
        GroupsChatPageAddMemberBottom(size: size),
        GroupsChatMembersPageListView(groupModel: groupModel,size: size),
      ],
    );
  }
}
