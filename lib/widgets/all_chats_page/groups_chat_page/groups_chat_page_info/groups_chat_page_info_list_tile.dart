import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_page/groups_chat_page_info_edit.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_page_info_list_tile_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getnav;

class GroupsChatPageInfoListTile extends StatelessWidget {
  const GroupsChatPageInfoListTile({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      leading: CircleAvatar(
          radius: size.height * .035,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(groupModel.groupImage!)),
      title: Row(
        children: [
          Text(groupModel.groupName),
          SizedBox(width: size.width * .02),
          GestureDetector(
              onTap: () {
                getnav.Get.to(
                    () => GroupsChatPageInfoEditPage(groupModel: groupModel),
                    transition: getnav.Transition.leftToRight);
              },
              child: Icon(Icons.edit,
                  color: Colors.grey, size: size.height * .022))
        ],
      ),
      subtitle: CustomSubTitle(groupModel: groupModel, size: size),
    );
  }
}
