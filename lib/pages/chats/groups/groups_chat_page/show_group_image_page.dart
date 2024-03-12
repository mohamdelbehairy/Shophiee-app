import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/show_group_image_page/show_group_image_page_body.dart';
import 'package:flutter/material.dart';

class ShowGroupImagePage extends StatelessWidget {
  const ShowGroupImagePage(
      {super.key, required this.groupModel, required this.size});
  final GroupModel groupModel;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: ShowGroupImagePageBody(groupModel: groupModel, size: size)),
    );
  }
}

