import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/utils/widget/messages/message_sound_length.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_sound_component.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageSound extends StatelessWidget {
  const GroupsChatCustomMessageSound(
      {super.key,
      required this.size,
      required this.message,
      required this.groupModel});
  final Size size;
  final MessageModel message;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: message.messageSoundPlaying == false
          ? size.height * .08
          : size.height * .09,
      width: size.width * .72,
      child: Padding(
          padding: EdgeInsets.only(left: size.width * .025),
          child: Stack(
            children: [
              GroupsChatCustomMessageSoundComponent(
                  groupModel: groupModel, size: size, message: message),
              if (message.messageSoundPlaying == false)
                MessageSoundLength(size: size, message: message),
            ],
          )),
    );
  }
}
