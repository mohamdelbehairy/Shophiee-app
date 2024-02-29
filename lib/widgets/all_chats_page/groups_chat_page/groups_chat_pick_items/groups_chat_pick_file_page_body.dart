import 'dart:io';

import 'package:app/utils/navigation.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_chat_text_field.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_send_chat_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class GroupsChatPickFilePageBody extends StatefulWidget {
  const GroupsChatPickFilePageBody(
      {super.key,
      required this.file,
      required this.messageFileName,
      this.isClick = false,
      required this.groupModel});
  final File file;
  final String messageFileName;
  final bool isClick;
  final GroupModel groupModel;

  @override
  State<GroupsChatPickFilePageBody> createState() =>
      _GroupsPagePickFilePageBodyState();
}

class _GroupsPagePickFilePageBodyState
    extends State<GroupsChatPickFilePageBody> {
  TextEditingController controller = TextEditingController();
  bool isClick = false;
  void navigation() {
    Navigation.navigationOnePop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sendMessage = context.read<GroupMessageCubit>();
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
          child: GroupsChatSendItemChatBottom(
            groupModel: widget.groupModel,
            isClick: isClick,
            onTap: () async {
              try {
                setState(() {
                  isClick = true;
                });
                await sendMessage.sendGroupMessage(
                    messageText: controller.text,
                    groupID: widget.groupModel.groupID,
                    image: null,
                    video: null,
                    phoneContactName: null,
                    phoneContactNumber: null,
                    file: widget.file,
                    messageFileName: widget.messageFileName,
                    filePath: widget.file.path);
                navigation();
              } finally {
                setState(() {
                  isClick = false;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
