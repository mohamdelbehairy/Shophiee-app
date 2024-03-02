import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/focused_icons_actions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatMemebrIconActions extends StatelessWidget {
  const GroupsChatMemebrIconActions(
      {super.key,
      required this.groupModel,
      required this.userData,
      required this.size});
  final GroupModel groupModel;
  final UserModel userData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (groupModel.createUserID == userData.userID)
          Icon(Icons.shield, color: kPrimaryColor),
        SizedBox(width: size.width * .015),
        if (userData.userID != FirebaseAuth.instance.currentUser!.uid)
          Padding(
            padding: EdgeInsets.only(right: size.width * .02),
            child: FocusedIconActions(
                size: size, userData: userData, groupModel: groupModel),
          ),
      ],
    );
  }
}
