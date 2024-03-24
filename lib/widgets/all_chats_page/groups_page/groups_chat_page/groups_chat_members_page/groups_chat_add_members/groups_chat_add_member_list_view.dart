import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_cubit.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_state.dart';
import 'package:app/cubit/groups/groups_members_details/groups_members_details_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_members_page/groups_chat_add_members/groups_chat_add_member_button.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_members_page/groups_chat_add_members/groups_chat_add_member_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGroupsMembersListView extends StatelessWidget {
  const AddGroupsMembersListView(
      {super.key, 
      required this.size,
       required this.groupModel});
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    var groupsMemberSelected = context.read<GroupsMemberSelectedCubit>();
    var addGroupsMember = context.read<GroupsMembersDetailsCubit>();

    return SafeArea(
      child: Container(
        height: size.height * .5,
        child:
            BlocBuilder<GroupsMemberSelectedCubit, GroupsMemberSelectedState>(
          builder: (context, state) {
            return Card(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * .03, horizontal: size.width * .03),
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<GetFriendsCubit, GetFriendsState>(
                      builder: (context, state) {
                        if (state is GetFriendsSuccess &&
                            state.friends.isNotEmpty) {
                          return ListView.builder(
                            itemCount: state.friends.length,
                            itemBuilder: (context, index) {
                              return GroupsChatAddMembersListTile(
                                  size: size,
                                  groupModel: groupModel,
                                  user: state.friends[index]);
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  if (groupsMemberSelected
                      .getGroupsMemberSelectedFriendsList.isNotEmpty)
                    GroupsChatAddMemberButton(
                        size: size,
                        onTap: () async {
                          Navigator.pop(context);
                          await addGroupsMember.addGroupMember(
                              groupID: groupModel.groupID,
                              memberID: groupsMemberSelected
                                  .getGroupsMemberSelectedFriendsList);
                          for (var friend in groupsMemberSelected
                              .getGroupsMemberSelectedFriendsList) {
                            groupsMemberSelected
                                .deleteGroupsMemberSelectedFriends(
                                    selectedFriendID: friend);
                          }
                        }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
