import 'package:app/constants.dart';
import 'package:app/cubit/groups/delete_groups/delete_groups_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPopMenuButton extends StatelessWidget {
  const CustomPopMenuButton(
      {super.key, required this.size, required this.groupModel});

  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    var deleteGroup = context.read<DeleteGroupsCubit>();
    return PopupMenuButton(
        icon: Icon(FontAwesomeIcons.ellipsisVertical, size: size.width * .06),
        itemBuilder: (context) => [
              PopupMenuItem(
                  child: Row(
                children: [
                  Icon(Icons.star, size: size.width * .04, color: Colors.black),
                  SizedBox(width: size.width * .025),
                  Text('Favourite')
                ],
              )),
              PopupMenuItem(
                  child: Row(
                children: [
                  Icon(Icons.volume_up,
                      size: size.width * .04, color: Colors.black),
                  SizedBox(width: size.width * .025),
                  Text('Mute')
                ],
              )),
              PopupMenuItem(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              backgroundColor: kPrimaryColor,
                              content: Text(groupModel.groupOwnerID ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? 'Are you sure to delete ${groupModel.groupName} group?'
                                  : 'Are you sure to leave ${groupModel.groupName} group?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancle',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    if (groupModel.groupOwnerID ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                      await deleteGroup
                                          .deleteAndLeaveGroupOwner(
                                              groupID: groupModel.groupID);
                                    } else {
                                      await deleteGroup.leaveGroupMember(
                                          groupID: groupModel.groupID);
                                    }
                                  },
                                  child: Text('Ok',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ]);
                        });
                  },
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.arrowRightFromBracket,
                          size: size.width * .04, color: Colors.black),
                      SizedBox(width: size.width * .025),
                      Text(groupModel.groupOwnerID ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? 'Delete and Leave Group'
                          : 'Leave Group')
                    ],
                  )),
            ]);
  }
}
