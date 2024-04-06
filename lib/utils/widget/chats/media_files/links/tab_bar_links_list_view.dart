import 'package:app/constants.dart';
import 'package:app/cubit/chat_media_files/chat_get_media_files/chat_get_media_files_cubit.dart';
import 'package:app/cubit/groups/groups_mdeia_files/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/utils/widget/chats/media_files/links/tab_bar_links_list_tile.dart';
import 'package:flutter/material.dart';

class TabBarLinksListView extends StatelessWidget {
  const TabBarLinksListView(
      {super.key, required this.size, this.linksGroupList, this.linksChatList});

  final GroupGetMediaFilesCubit? linksGroupList;
  final ChatGetMediaFilesCubit? linksChatList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:
            linksGroupList?.linksList.length ?? linksChatList?.linksList.length,
        itemBuilder: (context, index) {
          return Card(
            color: kPrimaryColor,
            child: TabBarLinksListTile(
                mediaFiles: linksGroupList?.linksList[index] ??
                    linksChatList!.linksList[index],
                size: size),
          );
        });
  }
}
