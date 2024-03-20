import 'dart:io';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_pick_sound_button.dart';
import 'package:app/utils/widget/chats/pick_sound_page_body.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class GroupsChatPickSoundPage extends StatelessWidget {
  const GroupsChatPickSoundPage(
      {super.key,
      required this.sound,
      required this.size,
      required this.groupModel});
  final File sound;
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    String soundName = path.basename(sound.path);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: Color(0xff000101),
        title: Text(
          soundName,
          style: TextStyle(
              color: Colors.white,
              fontSize: size.height * .025,
              fontWeight: FontWeight.normal),
        ),
      ),
      body: Stack(
        children: [
          PickSoundPageBody(size: size, file: sound),
          GroupsChatPickSoundButton(
              size: size,
              sound: sound,
              groupModel: groupModel,
              audioName: soundName),
        ],
      ),
    );
  }
}
