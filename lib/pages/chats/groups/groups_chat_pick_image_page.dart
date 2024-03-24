import 'dart:io';

import 'package:app/models/group_model.dart';

import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_pick_items/groups_chat_pick_image_page_body.dart';
import 'package:flutter/material.dart';

class GroupsChatPickImagePage extends StatelessWidget {
  const GroupsChatPickImagePage(
      {super.key, required this.image, required this.groupModel});
  final File image;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GroupsChatPickImagePageBody(image: image, groupModel: groupModel),
    );
  }
}
