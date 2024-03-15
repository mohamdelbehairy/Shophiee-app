import 'dart:io';

import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/navigation.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_item_send_chat_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickVideoSendVideoMessageButton extends StatefulWidget {
  const PickVideoSendVideoMessageButton(
      {super.key,
      required this.size,
      required this.user,
      required this.video,
      required this.controller});
  final Size size;
  final UserModel user;
  final File video;
  final TextEditingController controller;

  @override
  State<PickVideoSendVideoMessageButton> createState() =>
      _PickVideoSendVideoMessageButtonState();
}

class _PickVideoSendVideoMessageButtonState
    extends State<PickVideoSendVideoMessageButton> {
  bool isClick = false;

  navigation() {
    Navigation.navigationOnePop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final message = context.read<MessageCubit>();
    return Positioned(
      width: widget.size.width,
      bottom: widget.size.height * .015,
      child: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
        builder: (context, state) {
          if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              final userData = state.userModel
                  .firstWhere((element) => element.userID == currentUser.uid);
              return PickItemSendChatItemBottom(
                user: widget.user,
                isClick: isClick,
                onTap: () async {
                  try {
                    setState(() {
                      isClick = true;
                    });
                    await message.sendMessage(
                        friendNameReplay: '',
                        replayImageMessage: '',
                        replayMessageID: '',
                        image: null,
                        file: null,
                        phoneContactNumber: null,
                        phoneContactName: null,
                        video: widget.video,
                        videoPath: widget.video.path,
                        receiverID: widget.user.userID,
                        messageText: widget.controller.text,
                        userName: widget.user.userName,
                        profileImage: widget.user.profileImage,
                        userID: widget.user.userID,
                        myUserName: userData.userName,
                        myProfileImage: userData.profileImage,
                        // context: context
                        
                        );
                  } finally {
                    setState(() {
                      isClick = false;
                    });
                    navigation();
                  }
                },
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
