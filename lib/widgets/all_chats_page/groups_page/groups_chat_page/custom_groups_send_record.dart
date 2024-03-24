import 'dart:io';

import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/upload/upload_audio/upload_audio_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/utils/widget/chats/recorder_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGroupsSendRecord extends StatelessWidget {
  const CustomGroupsSendRecord(
      {super.key,
      required this.size,
      required this.groupChat,
      required this.groupModel});

  final Size size;
  final GroupMessageCubit groupChat;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    var uploadAudio = context.read<UploadAudioCubit>();
    return RecorderItem(
      size: size,
      sendRequestFunction: (File soundFile, String time) async {
        String audioUrl = await uploadAudio.uploadAudio(
            audioFile: soundFile, audioField: 'groups_messages_audio');
        await groupChat.sendGroupMessage(
            recordTime: time,
            recordUrl: audioUrl,
            messageText: '',
            groupID: groupModel.groupID, replayImageMessage: '', friendNameReplay: '', replayMessageID: '');
      },
    );
  }
}
