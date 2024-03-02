import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_member_icon_actions.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_members_status.dart';
import 'package:flutter/material.dart';

class GroupsChatMembersListTile extends StatelessWidget {
  const GroupsChatMembersListTile(
      {super.key,
      required this.userData,
      required this.size,
      required this.groupModel});
  final UserModel userData;
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * .7,
          child: ListTile(
            title: Text(userData.userName,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(userData.profileImage),
                ),
                Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: GroupsChatMembersStatus(size: size)),
              ],
            ),
          ),
        ),
        GroupsChatMemebrIconActions(
            groupModel: groupModel, userData: userData, size: size),
      ],
    );
  }
}
