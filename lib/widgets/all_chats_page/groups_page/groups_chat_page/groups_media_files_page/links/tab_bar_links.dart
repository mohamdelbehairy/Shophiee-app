import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/custom_text_no_media_fiels.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/links/tab_bar_links_list_view.dart';
import 'package:flutter/material.dart';

class TabBarLinks extends StatelessWidget {
  const TabBarLinks({super.key, required this.linksList, required this.size});
  final GroupGetMediaFilesCubit linksList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if (linksList.filesList.isEmpty) {
      return CustomTextNoMediaFiels(
          size: size, text: 'No shared links here yet');
    }
    return TabBarLinksListView(linksList: linksList, size: size);
  }
}

