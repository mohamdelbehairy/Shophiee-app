import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/upload/upload_audio/upload_audio_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

class RecorderItem extends StatelessWidget {
  const RecorderItem(
      {super.key,
      required this.size,
      required this.message,
      required this.user});
  final Size size;
  final MessageCubit message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var uploadAudio = context.read<UploadAudioCubit>();

    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            final userData = state.userModel
                .firstWhere((element) => element.userID == currentUser.uid);
            return SocialMediaRecorder(
                initRecordPackageWidth: size.height * .055,
                fullRecordPackageHeight: size.height * .055,
                radius: BorderRadius.circular(size.height * .05),
                backGroundColor: kPrimaryColor,
                recordIconBackGroundColor: kPrimaryColor,
                recordIconWhenLockBackGroundColor: kPrimaryColor,
                recordIcon: Icon(FontAwesomeIcons.microphone,
                    color: Colors.white, size: size.height * .025),
                sendRequestFunction: (soundFile, time) async {
                  String recordUrl = await uploadAudio.uploadAudio(
                      audioFile: soundFile, audioField: 'messages_record');
                  await message.sendMessage(
                      recordUrl: recordUrl,
                      recordTime: time,
                      receiverID: user.userID,
                      messageText: '',
                      userName: user.userName,
                      profileImage: user.profileImage,
                      userID: user.userID,
                      myUserName: userData.userName,
                      myProfileImage: userData.profileImage,
                      replayImageMessage: '',
                      friendNameReplay: '',
                      replayMessageID: '');
                },
                encode: AudioEncoderType.AAC);
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
