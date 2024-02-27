import 'dart:io';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_pick_items/groups_chat_pick_file_page_body.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class GroupsChatPickFilePage extends StatelessWidget {
  const GroupsChatPickFilePage(
      {super.key, required this.file, required this.groupModel});
  final File file;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    String fileName = path.basename(file.path);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: Color(0xff000101),
        title: Text(
          fileName,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.height * .03,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: GroupsChatPickFilePageBody(file: file, messageFileName: fileName, groupModel: groupModel),
    );
  }
}
