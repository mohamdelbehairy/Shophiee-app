import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/send_message/send_message_button.dart';
import 'package:app/widgets/all_chats_page/chat_page/message_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageItemSendMessage extends StatelessWidget {
  const ChatPageItemSendMessage(
      {super.key,
      required this.textEditingController,
      required this.message,
      required this.user,
      required this.scrollController,
      required this.onPressed,
      required this.focusNode,
      required this.replayTextMessage,
      required this.friendNameReplay,
      required this.replayImageMessage,
      required this.replayFileMessage,
      required this.replayContactMessage,
      required this.replayMessageID});

  final TextEditingController textEditingController;
  final MessageCubit message;
  final UserModel user;
  final ScrollController scrollController;
  final Function() onPressed;
  final FocusNode focusNode;
  final String replayTextMessage;
  final String friendNameReplay;
  final String replayImageMessage;
  final String replayFileMessage;
  final String replayContactMessage;
  final String replayMessageID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, right: 12, left: 12),
      child: Row(
        children: [
          MessageTextField(
              onPressed: onPressed,
              controller: textEditingController,
              onChanged: (value) {},
              focusNode: focusNode),
          BlocBuilder<GetUserDataCubit, GetUserDataStates>(
            builder: (context, state) {
              if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  final userData = state.userModel.firstWhere(
                      (element) => element.userID == currentUser.uid);
                  return GestureDetector(
                      onTap: () async {
                        message.sendMessage(
                            replayContactMessage: replayContactMessage,
                            replayFileMessage: replayFileMessage,
                            replayImageMessage: replayImageMessage,
                            replayTextMessage: replayTextMessage,
                            friendNameReplay: friendNameReplay,
                            replayMessageID: replayMessageID,
                            receiverID: user.userID,
                            messageText: textEditingController.text,
                            userName: user.userName,
                            profileImage: user.profileImage,
                            userID: user.userID,
                            myUserName: userData.userName,
                            myProfileImage: userData.profileImage,
                            context: context);
                        textEditingController.clear();
                      
                        scrollController.animateTo(0,
                            duration: const Duration(microseconds: 20),
                            curve: Curves.easeIn);
                      },
                      child: SendMessageButton(icon: Icons.send));
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
