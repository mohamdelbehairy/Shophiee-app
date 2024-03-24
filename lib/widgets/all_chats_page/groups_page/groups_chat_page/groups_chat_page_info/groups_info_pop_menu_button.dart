import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_page/group_permissions_page.dart';
import 'package:app/pages/chats/groups/groups_chat_page/groups_chat_members_page.dart';
import 'package:app/pages/chats/groups/groups_chat_page/groups_chat_page_info_edit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_info/groups_info_pop_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getnav;

class GroupsInfoPopupMenueButton extends StatelessWidget {
  const GroupsInfoPopupMenueButton(
      {super.key, required this.size, required this.groupModel});

  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(0, size.height * .06),
      color: kPrimaryColor,
      itemBuilder: (context) => [
        if (groupModel.groupOwnerID == FirebaseAuth.instance.currentUser!.uid)
          groupsInfoPopMenuItem(
            size: size,
            itemName: 'Add member',
            onTap: () => getnav.Get.to(
                () => GroupsChatMembersPage(groupModel: groupModel),
                transition: getnav.Transition.leftToRight),
          ),
        groupsInfoPopMenuItem(
          size: size,
          itemName: 'Change group info',
          onTap: () {
            if (groupModel.groupOwnerID ==
                    FirebaseAuth.instance.currentUser!.uid ||
                groupModel.isMemberSettings ||
                groupModel.adminsID
                    .contains(FirebaseAuth.instance.currentUser!.uid)) {
              getnav.Get.to(
                  () => GroupsChatPageInfoEditPage(groupModel: groupModel),
                  transition: getnav.Transition.leftToRight);
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: kPrimaryColor,
                      content: Text('Only admins can edit this groups\'s info'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child:
                              Text('Ok', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  });
            }
          },
        ),
        if (groupModel.groupOwnerID == FirebaseAuth.instance.currentUser!.uid ||
            groupModel.adminsID
                .contains(FirebaseAuth.instance.currentUser!.uid))
          groupsInfoPopMenuItem(
            size: size,
            itemName: 'Group permissions',
            onTap: () => getnav.Get.to(
                () => GroupPermissionsPage(size: size, groupModel: groupModel),
                transition: getnav.Transition.leftToRight),
          ),
      ],
    );
  }
}
