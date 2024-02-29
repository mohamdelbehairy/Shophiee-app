import 'dart:io';

import 'package:app/utils/navigation.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_chat_text_field.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_item_send_chat_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PickFilePageBody extends StatefulWidget {
  const PickFilePageBody(
      {super.key,
      required this.file,
      required this.messageFileName,
      this.isClick = false,
      required this.user,
      required this.replayTextMessage,
      required this.replayImageMessage, required this.replayFileMessage});
  final File file;
  final String messageFileName;
  final bool isClick;
  final UserModel user;
  final String replayTextMessage;
  final String replayImageMessage;
  final String replayFileMessage;

  @override
  State<PickFilePageBody> createState() => _GroupsPagePickFilePageBodyState();
}

class _GroupsPagePickFilePageBodyState extends State<PickFilePageBody> {
  TextEditingController controller = TextEditingController();
  bool isClick = false;
  void navigation() {
    Navigation.navigationOnePop(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final message = context.read<MessageCubit>();
    return Stack(
      children: [
        PDFView(
          filePath: widget.file.path,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          onError: (error) {
            print('error from pdf method: $error');
          },
        ),
        Positioned(
          height: size.height * .18,
          width: size.width,
          bottom: 0.0,
          child: PickChatTextField(
              controller: controller, hintText: 'Add a caption...'),
        ),
        Positioned(
          width: size.width,
          bottom: size.height * .015,
          child: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
            builder: (context, state) {
              if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  final userData = state.userModel.firstWhere(
                      (element) => element.userID == currentUser.uid);
                  return PickItemSendChatItemBottom(
                      user: widget.user,
                      isClick: isClick,
                      onTap: () async {
                        try {
                          setState(() {
                            isClick = true;
                          });
                          await message.sendMessage(
                              receiverID: widget.user.userID,
                              messageText: controller.text,
                              userName: widget.user.userName,
                              profileImage: widget.user.profileImage,
                              userID: widget.user.userID,
                              myUserName: userData.userName,
                              myProfileImage: userData.profileImage,
                              context: context,
                              image: null,
                              video: null,
                              phoneContactNumber: null,
                              phoneContactName: null,
                              file: widget.file,
                              filePath: widget.file.path,
                              replayFileMessage: widget.replayFileMessage,
                              replayTextMessage: widget.replayTextMessage,
                              replayImageMessage: widget.replayImageMessage,
                              replayContactMessage: '',
                              messageFileName: widget.messageFileName);
                          navigation();
                        } finally {
                          setState(() {
                            isClick = false;
                          });
                        }
                      });
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}
