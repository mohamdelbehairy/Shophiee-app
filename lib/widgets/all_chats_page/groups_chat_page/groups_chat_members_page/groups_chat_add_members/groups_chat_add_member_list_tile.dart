import 'package:app/constants.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_cubit.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatAddMembersListTile extends StatefulWidget {
  const GroupsChatAddMembersListTile(
      {super.key,
      required this.size,
      required this.groupModel,
      required this.user});

  final Size size;
  final GroupModel groupModel;
  final UserModel user;

  @override
  State<GroupsChatAddMembersListTile> createState() =>
      _GroupsChatAddMembersListTileState();
}

class _GroupsChatAddMembersListTileState
    extends State<GroupsChatAddMembersListTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var selectedMembers = context.read<GroupsMemberSelectedCubit>();
    return GestureDetector(
      onTap: () async {
        setState(() {
          isSelected = !isSelected;
        });
        if (!widget.groupModel.usersID.contains(widget.user.userID)) {
          if (isSelected) {
            await selectedMembers.groupsMemberSelected(
                selectedFriendID: widget.user.userID,
                userName: widget.user.userName,
                profileImage: widget.user.profileImage,
                userID: widget.user.userID);
          } else {
            await selectedMembers.deleteGroupsMemberSelectedFriends(
                selectedFriendID: widget.user.userID);
          }
        }
      },
      child: BlocBuilder<GroupsMemberSelectedCubit, GroupsMemberSelectedState>(
        builder: (context, state) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.user.userName),
                if (!widget.groupModel.usersID.contains(widget.user.userID))
                  Container(
                    height: widget.size.height * .022,
                    width: widget.size.width * .05,
                    color: isSelected
                        // &&
                        // selectedFriends
                        //     .getGroupsMemberSelectedFriendsList.isNotEmpty
                        ? kPrimaryColor
                        : Colors.grey,
                    child: isSelected
                        //     &&
                        // selectedFriends
                        //     .getGroupsMemberSelectedFriendsList.isNotEmpty
                        ? Icon(Icons.done,
                            size: widget.size.height * .022,
                            color: Colors.white)
                        : Container(),
                  )
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(widget.user.profileImage),
            ),
            subtitle: Text(
                widget.groupModel.usersID.contains(widget.user.userID)
                    ? 'Already added to the group'
                    : widget.user.userID),
          );
        },
      ),
    );
  }
}
