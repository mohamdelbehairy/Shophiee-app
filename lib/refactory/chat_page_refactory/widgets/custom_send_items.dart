import 'package:app/cubit/message/message_cubit.dart';
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
import 'package:app/pages/chats/pick_video_page.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_refactory_item_send_message.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_refactory_send_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class CustomSendItems extends StatefulWidget {
  const CustomSendItems(
      {super.key,
      required this.size,
      required this.user,
      required this.textEditingController,
      required this.scrollController});
  final Size size;
  final UserModel user;
  final TextEditingController textEditingController;
  final ScrollController scrollController;

  @override
  State<CustomSendItems> createState() => _CustomSendItemsState();
}

class _CustomSendItemsState extends State<CustomSendItems> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    var message = context.read<MessageCubit>();
    return Column(
      children: [
        if (isClick)
          ChatPageRefactorySendItems(size: widget.size, user: widget.user),
        BlocListener<PickImageCubit, PickImageStates>(
          listener: (context, state) {
            if (state is PickImageScucccess) {
              getnav.Get.to(
                  () => PickImagePage(
                      image: state.image,
                      user: widget.user,
                      replayTextMessageImage: 'replayTextMessageImage',
                      replayImageMessageImage: 'replayImageMessageImage',
                      replayFileMessageImage: 'replayFileMessageImage',
                      replayContactMessageContact:
                          'replayContactMessageContact'),
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
                  getnav.Get.to(
                      () => PickFilePage(
                            file: state.file,
                            user: widget.user,
                            replayTextMessage: '',
                            replayImageMessage: '',
                            replayFileMessage: '',
                          ),
                      transition: getnav.Transition.leftToRight);
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
                child: ChatPageRefactoryItemSendMessage(
                    onPressed: () {
                      setState(() {
                        isClick = !isClick;
                      });
                    },
                    textEditingController: widget.textEditingController,
                    message: message,
                    user: widget.user,
                    scrollController: widget.scrollController),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
