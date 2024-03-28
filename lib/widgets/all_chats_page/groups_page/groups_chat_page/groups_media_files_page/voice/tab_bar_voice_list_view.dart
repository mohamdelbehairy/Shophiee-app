import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/voice/tab_bar_voice_list_tile.dart';
import 'package:flutter/material.dart';

class TabBarVoiceListView extends StatelessWidget {
  const TabBarVoiceListView(
      {super.key, required this.voiceList, required this.size});
  final GroupGetMediaFilesCubit voiceList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: voiceList.voiceList.length,
        itemBuilder: (context, index) {
          return TabBarVoiceListTile(
              mediaFiles: voiceList.voiceList[index], size: size);
        });
  }
}
