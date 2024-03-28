import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/custom_text_no_media_files.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/voice/tab_bar_voice_list_view.dart';
import 'package:flutter/material.dart';

class TabBarVoice extends StatelessWidget {
  const TabBarVoice({super.key, required this.voiceList, required this.size});
  final GroupGetMediaFilesCubit voiceList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if (voiceList.voiceList.isEmpty) {
      return CustomTextNoMediaFiles(
          size: size, text: 'No shared voice here yet');
    }
    return TabBarVoiceListView(voiceList: voiceList, size: size);
  }
}
