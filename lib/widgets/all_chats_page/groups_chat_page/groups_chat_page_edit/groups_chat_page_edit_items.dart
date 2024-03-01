import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_edit/groups_chat_edit_image.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_edit/groups_chat_edit_text_field.dart';
import 'package:flutter/material.dart';

class GroupsChatPageEditItems extends StatelessWidget {
  const GroupsChatPageEditItems({super.key, required this.groupModel, required this.controller});
  final GroupModel groupModel;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * .01, horizontal: size.height * .02),
      child: Row(
        children: [
          GroupsChatEditImage(groupModel: groupModel),
          SizedBox(width: size.width * .04),
          GroupsChatEditTextField(controller: controller),
        ],
      ),
    );
  }
}
