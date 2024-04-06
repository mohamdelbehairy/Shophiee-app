import 'package:app/cubit/chat_media_files/chat_get_media_files/chat_get_media_files_cubit.dart';
import 'package:app/cubit/groups/groups_mdeia_files/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/utils/widget/media_files/custom_text_no_media_files.dart';
import 'package:app/utils/widget/media_files/voice/tab_bar_voice_list_view.dart';
import 'package:flutter/material.dart';

class TabBarVoice extends StatelessWidget {
  const TabBarVoice(
      {super.key, this.voiceGroupList, required this.size, this.voiceChatList});
  final GroupGetMediaFilesCubit? voiceGroupList;
  final ChatGetMediaFilesCubit? voiceChatList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if ((voiceGroupList?.voiceList != null &&
            voiceGroupList!.voiceList.isEmpty) ||
        (voiceChatList?.voiceList != null &&
            voiceChatList!.voiceList.isEmpty)) {
      return CustomTextNoMediaFiles(
          size: size, text: 'No shared voice here yet');
    }
    return TabBarVoiceListView(
        voiceGroupList: voiceGroupList,
        voiceChatList: voiceChatList,
        size: size);
  }
}
