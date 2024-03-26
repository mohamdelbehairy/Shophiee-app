import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/groups_chat_media_fiels_page_body.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/groups_chat_media_fiels_page_tab_bar.dart';
import 'package:flutter/material.dart';

class GroupsChatMediaFielsPage extends StatefulWidget {
  const GroupsChatMediaFielsPage(
      {super.key, required this.groupModel, required this.size});
  final GroupModel groupModel;
  final Size size;

  @override
  State<GroupsChatMediaFielsPage> createState() =>
      _GroupsChatMediaFielsPageState();
}

class _GroupsChatMediaFielsPageState extends State<GroupsChatMediaFielsPage> {
  int titleIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(widget.groupModel.groupName),
          titleSpacing: widget.size.width * -.01,
          titleTextStyle: TextStyle(fontSize: widget.size.width * .06),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: GroupsChatMediaFielsPageTabBar(
                onTap: (index) {
                  setState(() {
                    titleIndex = index;
                  });
                },
                size: widget.size,
                titleIndex: titleIndex),
          ),
        ),
        body: GroupsChatMediaFielsPageBody(
            size: widget.size, groupModel: widget.groupModel),
      ),
    );
  }
}
