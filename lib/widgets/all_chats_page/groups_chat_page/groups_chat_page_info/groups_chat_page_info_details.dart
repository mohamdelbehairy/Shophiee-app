import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_page_info_list_tile.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_details_text.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_item_details.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_component.dart';
import 'package:flutter/material.dart';

class GroupsChatPageInfoDetails extends StatelessWidget {
  const GroupsChatPageInfoDetails({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding:
              EdgeInsets.only(left: 0.0, right: 0.0, top: size.width * .015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroupsChatPageInfoListTile(groupModel: groupModel),
              SizedBox(height: size.height * .01),
              GroupsDetailsText(size: size),
              Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
              SizedBox(height: size.height * .008),
              ItemDetails(itemName: 'Owner', itemValue: 'Mohamed'),
              ItemDetails(itemName: 'Owner\'s Email', itemValue: 'Mohamed'),
              ItemDetails(itemName: 'Owner\'s Bio', itemValue: 'Mohamed'),
              ItemDetails(itemName: 'Owner\'s Nick Name', itemValue: 'Mohamed'),
              ItemDetails(itemName: 'Groups\'s Name', itemValue: 'Mohamed'),
              ItemDetails(itemName: 'Number of members', itemValue: 'Mohamed'),
              Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
              GroupsChatComponent(componentName: 'Group Members', onTap: () {}),
              GroupsChatComponent(componentName: 'Highlights', onTap: () {}),
              GroupsChatComponent(componentName: 'Media files', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
