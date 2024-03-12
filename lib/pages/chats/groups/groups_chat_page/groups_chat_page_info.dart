import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_info_body.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/app_bar_icon.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_page_info_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupsChatPageInfo extends StatelessWidget {
  const GroupsChatPageInfo({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: const GroupsChatPageInfoAppBar(),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: size.width * .02),
              child: AppBarIcon(
                  icon: FontAwesomeIcons.ellipsisVertical,
                  iconsSize: size.height * .025,
                  onTap: () {}),
            )
          ],
        ),
        body: GroupsChatInfoBody(groupModel: groupModel));
  }
}
