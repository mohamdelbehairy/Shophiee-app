import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/upload_audio/upload_audio_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickSoundPageButton extends StatefulWidget {
  const PickSoundPageButton(
      {super.key,
      required this.size,
      required this.audioFile,
      required this.user,
      required this.audioName});
  final Size size;
  final File audioFile;
  final UserModel user;
  final String audioName;

  @override
  State<PickSoundPageButton> createState() => _PickSoundPageButtonState();
}

class _PickSoundPageButtonState extends State<PickSoundPageButton> {
  bool isLoading = false;

  void navigation() {
    Navigation.navigationOnePop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    var uploadAudio = context.read<UploadAudioCubit>();
    var sendMessage = context.read<MessageCubit>();
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            final userData = state.userModel
                .firstWhere((element) => element.userID == currentUser.uid);
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
                        audioFile: widget.audioFile);
                    await sendMessage.sendMessage(
                        audioUrl: audioUrl,
                        audioName: widget.audioName,
                        receiverID: widget.user.userID,
                        messageText: '',
                        userName: widget.user.userName,
                        profileImage: widget.user.profileImage,
                        userID: widget.user.userID,
                        myUserName: userData.userName,
                        myProfileImage: userData.profileImage,
                        replayImageMessage: '',
                        friendNameReplay: '',
                        replayMessageID: '');
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
