import 'package:app/constants.dart';
import 'package:app/cubit/groups/high_light_group_message/hight_light_messages/hight_light_messages_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/utils/custom_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupsHighLightAppBarActionIcon extends StatelessWidget {
  const GroupsHighLightAppBarActionIcon(
      {super.key,
      required this.size,
      required this.hightLightMessage,
      required this.groupModel});

  final Size size;
  final HightLightMessagesCubit hightLightMessage;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        offset: Offset(0, size.height * .05),
        icon: Icon(FontAwesomeIcons.ellipsisVertical, size: size.height * .025),
        itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () => customShowDialog(
                      context: context,
                      doneButtonText: 'Remove all',
                      contentText: 'Remove all messages?',
                      backgroundColor: kPrimaryColor,
                      okFunction: () async {
                        Navigator.pop(context);
                        await hightLightMessage.removeAllHighLightMessages(
                            groupID: groupModel.groupID);
                      }),
                  child: Padding(
                    padding: EdgeInsets.only(right: size.width * .044),
                    child: Text('Remove all',
                        style: TextStyle(color: Colors.white)),
                  ))
            ]);
  }
}
