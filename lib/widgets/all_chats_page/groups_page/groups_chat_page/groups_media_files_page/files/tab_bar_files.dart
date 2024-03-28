import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/custom_text_no_media_fiels.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/files/tab_bar_files_list_view.dart';
import 'package:flutter/material.dart';

class TabBarFiles extends StatelessWidget {
  const TabBarFiles({super.key, required this.filesList, required this.size});
  final GroupGetMediaFilesCubit filesList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if (filesList.filesList.isEmpty) {
      return CustomTextNoMediaFiels(size: size, text: 'No files here yet');
    }
    return TabBarFilesListView(filesList: filesList, size: size);
  }
}
