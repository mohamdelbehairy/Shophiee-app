import 'package:app/cubit/groups/get_groups_member/get_groups_member_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_members_page_list_view.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_add_members/groups_chat_page_add_member_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatMembersPageBody extends StatelessWidget {
  const GroupsChatMembersPageBody(
      {super.key,
      required this.size,
      required this.groupModel,
      required this.user});
  final Size size;
  final GroupModel groupModel;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetGroupsMemberCubit, GetGroupsMemberState>(
      builder: (context, state) {
        if (state is GetGroupsMemberSuccess && state.groupsList.isNotEmpty) {
          final groupID = groupModel.groupID;
          final groupData = state.groupsList
              .firstWhere((element) => element.groupID == groupID);
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
              GroupsChatPageAddMemberBottom(
                  size: size, user: user, groupModel: groupData),
              GroupsChatMembersPageListView(groupModel: groupData, size: size),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
