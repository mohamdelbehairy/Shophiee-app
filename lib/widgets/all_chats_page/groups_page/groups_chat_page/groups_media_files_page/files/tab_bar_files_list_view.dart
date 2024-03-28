import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/files/tab_bar_files_list_tile.dart';
import 'package:flutter/material.dart';

class TabBarFilesListView extends StatelessWidget {
  const TabBarFilesListView(
      {super.key, required this.filesList, required this.size});

  final GroupGetMediaFilesCubit filesList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: filesList.filesList.length,
        itemBuilder: (context, index) {
          double fileSize =
              double.parse('${filesList.filesList[index].messageFileSize!}');
          String roundedFileSize = fileSize.toStringAsFixed(1);
          return TabBarFielsListTile(
              size: size,
              mediaFiles: filesList.filesList[index],
              roundedFileSize: roundedFileSize);
        });
  }
}
