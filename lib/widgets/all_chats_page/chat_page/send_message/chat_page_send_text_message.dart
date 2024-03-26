import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/send_message/send_message_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageSendTextMessageButton extends StatelessWidget {
  const ChatPageSendTextMessageButton(
      {super.key,
      required this.messages,
      required this.user,
      required this.textEditingController,
      required this.replayTextMessage,
      required this.friendNameReplay,
      required this.replayImageMessage,
      required this.replayFileMessage,
      required this.replayContactMessage,
      required this.replayMessageID,
      required this.scrollController,
      required this.replaySoundMessage,
      required this.replayRecordMessage});

  final MessageCubit messages;
  final UserModel user;
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final String replayTextMessage;
  final String friendNameReplay;
  final String replayImageMessage;
  final String replayFileMessage;
  final String replayContactMessage;
  final String replayMessageID;
  final String replaySoundMessage;
  final String replayRecordMessage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            final userData = state.userModel
                .firstWhere((element) => element.userID == currentUser.uid);
            return SendMessageButton(
                onTap: () async {
                  messages.sendMessage(
                      receiverID: user.userID,
                      messageText: textEditingController.text,
                      userName: user.userName,
                      profileImage: user.profileImage,
                      userID: user.userID,
                      myUserName: userData.userName,
                      myProfileImage: userData.profileImage,
                      replayImageMessage: replayImageMessage,
                      friendNameReplay: friendNameReplay,
                      replayMessageID: replayMessageID,
                      replayContactMessage: replayContactMessage,
                      replayFileMessage: replayFileMessage,
                      replayTextMessage: replayTextMessage,
                      replaySoundMessage: replaySoundMessage,
                      replayRecordMessage: replayRecordMessage);

                  textEditingController.clear();
                  scrollController.animateTo(0,
                      duration: const Duration(microseconds: 20),
                      curve: Curves.easeIn);
                },
                icon: Icons.send);
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
