import 'dart:io';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_file_page_body.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class PickFilePage extends StatelessWidget {
  const PickFilePage(
      {super.key,
      required this.file,
      required this.user,
      required this.replayTextMessage,
      required this.replayImageMessage,
      required this.replayFileMessage,
      required this.friendNameReplay,
      required this.replayMessageID, required this.replayContactMessage});
  final File file;
  final UserModel user;
  final String replayTextMessage;
  final String replayImageMessage;
  final String replayFileMessage;
  final String friendNameReplay;
  final String replayMessageID;
  final String replayContactMessage;

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
      body: PickFilePageBody(
          replayContactMessage: replayContactMessage,
          friendNameReplay: friendNameReplay,
          replayMessageID: replayMessageID,
          file: file,
          user: user,
          messageFileName: fileName,
          replayTextMessage: replayTextMessage,
          replayImageMessage: replayImageMessage,
          replayFileMessage: replayFileMessage),
    );
  }
}
