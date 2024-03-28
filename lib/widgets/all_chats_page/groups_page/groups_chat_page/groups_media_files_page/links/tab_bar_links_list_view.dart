import 'package:app/constants.dart';
import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/links/tab_bar_links_list_tile.dart';
import 'package:flutter/material.dart';

class TabBarLinksListView extends StatelessWidget {
  const TabBarLinksListView(
      {super.key, required this.linksList, required this.size});

  final GroupGetMediaFilesCubit linksList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: linksList.linksList.length,
        itemBuilder: (context, index) {
          return Card(
            color: kPrimaryColor,
            child: TabBarLinksListTile(
                mediaFiles: linksList.linksList[index], size: size),
          );
        });
  }
}
