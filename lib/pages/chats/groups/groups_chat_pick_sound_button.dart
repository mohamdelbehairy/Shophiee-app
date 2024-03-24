import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/upload/upload_audio/upload_audio_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/utils/navigation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatPickSoundButton extends StatefulWidget {
  const GroupsChatPickSoundButton(
      {super.key,
      required this.size,
      required this.sound,
      required this.groupModel,
      required this.audioName});
  final Size size;
  final File sound;
  final GroupModel groupModel;
  final String audioName;

  @override
  State<GroupsChatPickSoundButton> createState() =>
      _GroupsChatPickSoundButtonState();
}

class _GroupsChatPickSoundButtonState extends State<GroupsChatPickSoundButton> {
  bool isLoading = false;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    computeAndPrintDuration();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var uploadAudio = context.read<UploadAudioCubit>();
    var sendMessage = context.read<GroupMessageCubit>();
    return Positioned(
      bottom: widget.size.height * .1,
      right: widget.size.width * .04,
      child: GestureDetector(
        onTap: () async {
          try {
            setState(() {
              isLoading = true;
            });
            String audioUrl = await uploadAudio.uploadAudio(
                audioField: 'groups_messages_sound', audioFile: widget.sound);
            String? audioTime = await computeAndPrintDuration();
            await sendMessage.sendGroupMessage(
                audioUrl: audioUrl,
                audioName: widget.audioName,
                audioTime: audioTime,
                messageText: '',
                groupID: widget.groupModel.groupID, replayImageMessage: '', friendNameReplay: '', replayMessageID: '');

            navigation();
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: CircleAvatar(
          radius: widget.size.height * .045,
          backgroundColor: kPrimaryColor,
          child: isLoading
              ? SizedBox(
                  height: widget.size.height * .035,
                  width: widget.size.width * .07,
                  child: CircularProgressIndicator(color: Colors.white))
              : Icon(Icons.send,
                  color: Colors.white, size: widget.size.height * .04),
        ),
      ),
    );
  }

  Future<String?> computeAndPrintDuration() async {
    audioPlayer.setSource(DeviceFileSource(widget.sound.path));

    Duration? audioDuration = await audioPlayer.getDuration();

    if (audioDuration == null) {
      return null;
    }
    String formattedDuration = formatTime(audioDuration.inSeconds);
    return formattedDuration;
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void navigation() {
    Navigation.navigationOnePop(context: context);
  }
}
