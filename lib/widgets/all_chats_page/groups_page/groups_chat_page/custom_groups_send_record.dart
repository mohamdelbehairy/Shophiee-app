import 'dart:io';

import 'package:app/cubit/groups/groups_mdeia_fiels/group_store_media_files/group_store_media_files_cubit.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/upload/upload_audio/upload_audio_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/widget/chats/recorder_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CustomGroupsSendRecord extends StatelessWidget {
  const CustomGroupsSendRecord(
      {super.key,
      required this.size,
      required this.groupChat,
      required this.groupModel,
      required this.isSwip,
      this.messageModel,
      this.userData,
      this.stopRecording});

  final Size size;
  final GroupMessageCubit groupChat;
  final GroupModel groupModel;
  final bool isSwip;
  final MessageModel? messageModel;
  final UserModel? userData;
  final Function(String)? stopRecording;
  @override
  Widget build(BuildContext context) {
    var uploadAudio = context.read<UploadAudioCubit>();
    var storeVoice = context.read<GroupStoreMediaFielsCubit>();
    return RecorderItem(
      size: size,
      stopRecording: stopRecording,
      sendRequestFunction: (File soundFile, String time) async {
        String audioUrl = await uploadAudio.uploadAudio(
            audioFile: soundFile, audioField: 'groups_messages_audio');
        String messageID = const Uuid().v4();
        await groupChat.sendGroupMessage(
          
          messageID: messageID,
          recordTime: time,
          recordUrl: audioUrl,
          messageText: '',
          groupID: groupModel.groupID,
          replayTextMessage: isSwip ? messageModel!.messageText : '',
          friendNameReplay: isSwip
              ? userData != null
                  ? userData!.userName
                  : ''
              : '',
          replayImageMessage: isSwip
              ? messageModel!.messageImage != null &&
                          messageModel!.messageText == '' ||
                      messageModel!.messageImage != null &&
                          messageModel!.messageText != ''
                  ? messageModel!.messageImage!
                  : ''
              : '',
          replayFileMessage: isSwip && messageModel!.messageFileName != null
              ? messageModel!.messageFileName!
              : '',
          replayContactMessage:
              isSwip && messageModel!.phoneContactNumber != null
                  ? messageModel!.phoneContactNumber!
                  : '',
          replayMessageID: isSwip ? messageModel!.messageID : '',
          replaySoundMessage: isSwip && messageModel!.messageSound != null
              ? messageModel!.messageSoundName!
              : '',
          replayRecordMessage: isSwip && messageModel!.messageRecord != null
              ? messageModel!.messageRecord!
              : '',
        );
        await storeVoice.storeVoice(
            messageID: messageID,
            groupID: groupModel.groupID,
            messageRecord: audioUrl);
      },
    );
  }
}
