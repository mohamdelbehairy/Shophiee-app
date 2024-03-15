import 'dart:io';

import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_sound_page/pick_sound_page_body.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class PickSoundPage extends StatelessWidget {
  const PickSoundPage({super.key, required this.size, required this.file});
  final Size size;
  final File file;

  @override
  Widget build(BuildContext context) {
    String soundName = path.basename(file.path);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: Color(0xff000101),
        title: Text(
          soundName,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.height * .03,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: PickSoundPageBody(size: size, file: file),
    );
  }
}

