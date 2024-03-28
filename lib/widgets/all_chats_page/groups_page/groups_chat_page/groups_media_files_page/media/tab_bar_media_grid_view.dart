import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/media/tab_bar_media_image.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/media/tab_bar_media_video.dart';
import 'package:flutter/material.dart';

class TabBarMediaGridView extends StatelessWidget {
  const TabBarMediaGridView(
      {super.key, required this.mediaList, required this.size});

  final GroupGetMediaFilesCubit mediaList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .9,
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2),
        itemCount: mediaList.mediaList.length,
        itemBuilder: (context, index) {
          if (mediaList.mediaList[index].messageImage != null) {
            return TabBarMediaImage(mediaFiels: mediaList.mediaList[index]);
          } else {
            return TabBarMediaVideo(
                mediaFiels: mediaList.mediaList[index], size: size);
          }
        });
  }
}
