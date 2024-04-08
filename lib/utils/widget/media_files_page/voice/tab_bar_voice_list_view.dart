import 'package:app/cubit/chat_media_files/chat_get_media_files/chat_get_media_files_cubit.dart';
import 'package:app/cubit/groups/groups_mdeia_files/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/utils/widget/media_files_page/voice/tab_bar_voice_list_tile.dart';
import 'package:flutter/material.dart';

class TabBarVoiceListView extends StatelessWidget {
  const TabBarVoiceListView(
      {super.key, this.voiceGroupList, required this.size, this.voiceChatList});
  final GroupGetMediaFilesCubit? voiceGroupList;
  final ChatGetMediaFilesCubit? voiceChatList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:
            voiceGroupList?.voiceList.length ?? voiceChatList?.voiceList.length,
        itemBuilder: (context, index) {
          return TabBarVoiceListTile(
              mediaFiles: voiceGroupList?.voiceList[index] ??
                  voiceChatList!.voiceList[index],
              size: size);
        });
  }
}
