import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_add_members/groups_chat_add_member_list_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupsChatPageAddMemberBottomSheet extends StatelessWidget {
  const GroupsChatPageAddMemberBottomSheet(
      {super.key,
      required this.size,
    
      required this.groupModel});
  final Size size;
  
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .03),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) =>
                AddGroupsMembersListView(size: size, groupModel: groupModel)),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.plus,
                color: Colors.blue, size: size.height * .025),
            SizedBox(width: size.width * .025),
            Text('Add a member',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: size.height * .018,
                    fontWeight: FontWeight.normal))
          ],
        ),
      ),
    );
  }
}
