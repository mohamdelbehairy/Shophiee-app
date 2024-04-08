import 'package:app/constants.dart';
import 'package:app/cubit/chat_high_lights/chat_high_light_message/chat_high_light_message_cubit.dart';
import 'package:app/cubit/groups/high_light_group_message/hight_light_messages/high_light_messages_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/custom_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HighLightAppBarActionIcon extends StatelessWidget {
  const HighLightAppBarActionIcon(
      {super.key,
      required this.size,
      this.hightLightMessage,
      this.groupModel,
      this.chatHighLightMessage,
      this.user});

  final Size size;
  final HightLightMessagesCubit? hightLightMessage;
  final GroupModel? groupModel;
  final ChatHighLightMessageCubit? chatHighLightMessage;
  final UserModel? user;

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
                        if (groupModel != null && hightLightMessage != null) {
                          await hightLightMessage!.removeAllHighLightMessages(
                              groupID: groupModel!.groupID);
                        }
                        if (user != null && chatHighLightMessage != null) {
                          await chatHighLightMessage!
                              .removeAllHighLightMessages(
                                  friendID: user!.userID);
                        }
                      }),
                  child: Padding(
                    padding: EdgeInsets.only(right: size.width * .044),
                    child: Text('Remove all',
                        style: TextStyle(color: Colors.white)),
                  ))
            ]);
  }
}
