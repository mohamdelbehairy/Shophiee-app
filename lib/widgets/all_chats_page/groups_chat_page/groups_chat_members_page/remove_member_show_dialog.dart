import 'package:app/constants.dart';
import 'package:app/cubit/groups/groups_members_details/groups_members_details_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:flutter/material.dart';

Future<dynamic> removeMemberShowDialog(
    {required BuildContext context,
    required GroupsMembersDetailsCubit removeGroupMember,
    required UserModel userData,
    required GroupModel groupModel}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          content: Text(
              'Remove ${userData.userName.split(' ')[0]} from this group?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancle', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await removeGroupMember.removeGroupMember(
                    groupID: groupModel.groupID, memberID: userData.userID);
              },
              child: Text('Ok', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      });
}
