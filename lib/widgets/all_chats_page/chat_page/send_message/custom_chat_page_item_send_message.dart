import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_state.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/cubit/pick_file/pick_file_state.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/cubit/pick_video/pick_video_cubit.dart';
import 'package:app/cubit/pick_video/pick_video_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/pick_file_page.dart';
import 'package:app/pages/chats/pick_image_page.dart';
import 'package:app/pages/chats/pick_soud_page.dart';
import 'package:app/pages/chats/pick_video_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/message_text_field.dart';
import 'package:app/widgets/all_chats_page/chat_page/send_message/chat_page_choose_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class CustomChatPageItemSendMessage extends StatefulWidget {
  const CustomChatPageItemSendMessage({
    super.key,
    required this.size,
    required this.user,
    required this.textEditingController,
    required this.scrollController,
    required this.focusNode,
    required this.replayTextMessage,
    required this.friendNameReplay,
    required this.replayImageMessage,
    required this.replayFileMessage,
    required this.replayContactMessage,
    required this.replayMessageID,
    required this.onCanged,
  });
  final Size size;
  final UserModel user;
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final String replayTextMessage;
  final String friendNameReplay;
  final String replayImageMessage;
  final String replayFileMessage;
  final String replayContactMessage;
  final String replayMessageID;
  final Function(String) onCanged;
  @override
  State<CustomChatPageItemSendMessage> createState() =>
      _CustomChatPageItemSendMessageState();
}

class _CustomChatPageItemSendMessageState
    extends State<CustomChatPageItemSendMessage> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isClick) ChatPageChooseMedia(size: widget.size, user: widget.user),
        BlocListener<PickImageCubit, PickImageStates>(
          listener: (context, state) {
            if (state is PickImageScucccess) {
              getnav.Get.to(
                  () => PickImagePage(
                      friendNameReplay: widget.friendNameReplay,
                      replayMessageID: widget.replayMessageID,
                      image: state.image,
                      user: widget.user,
                      replayTextMessageImage: widget.replayTextMessage,
                      replayImageMessageImage: widget.replayImageMessage,
                      replayFileMessageImage: widget.replayFileMessage,
                      replayContactMessageContact: widget.replayContactMessage),
                  transition: getnav.Transition.leftToRight);
              setState(() {
                isClick = false;
              });
            }
          },
          child: BlocListener<PickVideoCubit, PickVideoState>(
            listener: (context, state) {
              if (state is PickVideoSuccess) {
                getnav.Get.to(
                    () => PickVideoPage(video: state.video, user: widget.user),
                    transition: getnav.Transition.leftToRight);
              }
              setState(() {
                isClick = false;
              });
            },
            child: BlocListener<PickFileCubit, PickFileState>(
              listener: (context, state) {
                if (state is PickFileSuccess) {
                  final file = state.file;
                  if (file.path.toLowerCase().endsWith('.pdf') ||
                      file.path.toLowerCase().endsWith('.doc')) {
                    getnav.Get.to(
                        () => PickFilePage(
                              size: widget.size,
                              replayContactMessage: widget.replayContactMessage,
                              friendNameReplay: widget.friendNameReplay,
                              replayMessageID: widget.replayMessageID,
                              file: state.file,
                              user: widget.user,
                              replayTextMessage: widget.replayTextMessage,
                              replayImageMessage: widget.replayImageMessage,
                              replayFileMessage: widget.replayFileMessage,
                            ),
                        transition: getnav.Transition.leftToRight);
                  }
                  if (file.path.toLowerCase().endsWith('.mp3')) {
                    getnav.Get.to(
                        () => PickSoundPage(
                            friendNameReplay: widget.friendNameReplay,
                            replayMessageID: widget.replayMessageID,
                            replayTextMessage: widget.replayTextMessage,
                            replayImageMessage: widget.replayImageMessage,
                            replayFileMessage: widget.replayFileMessage,
                            replayContactMessage: widget.replayContactMessage,
                            size: widget.size,
                            file: state.file,
                            user: widget.user),
                        transition: getnav.Transition.leftToRight);
                  }
                }
                setState(() {
                  isClick = false;
                });
              },
              child: BlocListener<PickContactCubit, PickContactState>(
                listener: (context, state) {
                  if (state is PickContactSuccess) {
                    setState(() {
                      isClick = false;
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: widget.size.width * .01,
                      right: widget.size.width * .15,
                      left: widget.size.width * .05),
                  child: MessageTextField(
                      onPressed: () {
                        setState(() {
                          isClick = !isClick;
                        });
                      },
                      controller: widget.textEditingController,
                      onChanged: widget.onCanged,
                      focusNode: widget.focusNode),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
