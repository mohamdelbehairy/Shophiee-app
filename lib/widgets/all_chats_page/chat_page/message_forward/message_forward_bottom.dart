import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/cubit/forward_selected_friend/forward_selected_friend_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class MessageForwardBottom extends StatefulWidget {
  const MessageForwardBottom(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  State<MessageForwardBottom> createState() => _MessageForwardBottomState();
}

class _MessageForwardBottomState extends State<MessageForwardBottom> {
  bool isCircle = false;

  showToastMethod() {
    ShowToast(
        context: context,
        showToastText: 'Message forward successfully',
        position: StyledToastPosition.center);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var selectedFriend = context.read<ForwardSelectedFriendCubit>();
    var sendMessage = context.read<MessageCubit>();

    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            final userData = state.userModel
                .firstWhere((element) => element.userID == currentUser.uid);
            return GestureDetector(
              onTap: () async {
                try {
                  setState(() {
                    isCircle = true;
                  });
                  for (var friend in selectedFriend.selectedFriendList) {
                    await sendMessage.sendMessage(
                        friendNameReplay: '',
                        replayMessageID: '',
                        image: widget.message.messageImageFile != null
                            ? File(widget.message.messageImageFile!)
                            : null,
                        imagePath: widget.message.messageImageFile,
                        video: widget.message.messageVideoFile != null
                            ? File(widget.message.messageVideoFile!)
                            : null,
                        videoPath: widget.message.messageVideoFile,
                        file: widget.message.messageFileFile != null
                            ? File(widget.message.messageFileFile!)
                            : null,
                        filePath: widget.message.messageFileFile,
                        phoneContactName: widget.message.phoneContactName,
                        phoneContactNumber: widget.message.phoneContactNumber,
                        messageFileName: widget.message.messageFileName,
                        receiverID: friend.userID,
                        messageText: widget.message.messageText,
                        userName: friend.userName,
                        profileImage: friend.profileImage,
                        userID: friend.userID,
                        myUserName: userData.userName,
                        myProfileImage: userData.profileImage,
                        context: context,
                        replayImageMessage: '',
                        replayTextMessage: '');
                    showToastMethod();
                  }
                } finally {
                  setState(() {
                    isCircle = false;
                  });
                  await selectedFriend.deleteAllSelectedFriends();
                }
              },
              child: CircleAvatar(
                radius: size.width * .08,
                backgroundColor: kPrimaryColor,
                child: isCircle
                    ? SizedBox(
                        height: size.width * .07,
                        width: size.width * .07,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Icon(Icons.send,
                        color: Colors.white, size: size.width * .07),
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
