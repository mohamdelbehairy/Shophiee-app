import 'package:app/constants.dart';
import 'package:app/cubit/groups/selected_friends/selected_friends_cubit.dart';
import 'package:app/cubit/groups/selected_friends/selected_friends_state.dart';
import 'package:app/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupListTile extends StatefulWidget {
  const CreateGroupListTile(
      {super.key,
      required this.isDark,
      required this.user,
      required this.size});

  final bool isDark;
  final UserModel user;
  final Size size;

  @override
  State<CreateGroupListTile> createState() => _CreateGroupListTileState();
}

class _CreateGroupListTileState extends State<CreateGroupListTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    var selectedFriends = context.read<SelectedFriendsCubit>();
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            setState(() {
              isSelected = !isSelected;
            });
            if (isSelected) {
              await selectedFriends.selectedFriends(
                  selectedFriendID: widget.user.userID,
                  userName: widget.user.userName,
                  profileImage: widget.user.profileImage,
                  userID: widget.user.userID);
            } else {
              selectedFriends.deleteSelectedFriends(
                  selectedFriendID: widget.user.userID);
            }
          },
          child: BlocBuilder<SelectedFriendsCubit,SelectedFriendsState>(
            builder: (context,state) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.user.userName,
                        style: TextStyle(
                            color: widget.isDark ? Colors.white : Colors.black)),
                    Container(
                      height: widget.size.height * .025,
                      width: widget.size.width * .05,
                      color: isSelected && selectedFriends.getFriendsList.isNotEmpty
                          ? kPrimaryColor
                          : Colors.grey,
                      child: isSelected && selectedFriends.getFriendsList.isNotEmpty
                          ? Icon(Icons.done, size: widget.size.height * .022)
                          : Container(),
                    )
                  ],
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(widget.user.profileImage),
                ),
              );
            },

          ),
        ),
      ],
    );
  }
}
