import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_file_replaying_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_image_replaying_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/all_chats_page/chat_page/custom_message/item_contact_replaying_message.dart';
import '../../../widgets/all_chats_page/chat_page/custom_message/replaying_message_item_component.dart';

class ReplayRecordMessage extends StatelessWidget {
  const ReplayRecordMessage(
      {super.key,
      required this.size,
      required this.message,
      required this.messageTextColor});
  final Size size;
  final MessageModel message;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: size.height * .03,
            width: size.width * .005,
            margin: EdgeInsets.only(
                top: size.width * .015,
                left: message.replayImageMessage != ''
                    ? size.width * .001
                    : message.replayFileMessage != null &&
                            message.replayTextMessage != ''
                        ? size.width * .03
                        : size.width * .03),
            color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Colors.white
                : Colors.grey),
        if (message.replayImageMessage != '')
          Padding(
              padding: EdgeInsets.only(
                  top: size.width * .025, left: size.width * .02),
              child: ItemImageReplayingMessage(
                  size: size, isDark: isDark, message: message)),
        if (message.replayFileMessage != null &&
            message.replayTextMessage == '')
          SizedBox(width: size.width * .015),
        if (message.replayFileMessage != '' && message.replayTextMessage != '')
          SizedBox(width: size.width * .015),
        if (message.replayFileMessage != '')
          Padding(
              padding: EdgeInsets.only(top: size.width * .025),
              child: ItemsFileReplayingMessage(size: size, message: message)),
        if (message.replayContactMessage != null &&
            message.replayTextMessage == '' &&
            message.replayImageMessage == '' &&
            message.replayFileMessage == '')
          Padding(
              padding: EdgeInsets.only(top: size.width * .025),
              child: ItemContactReplayingMessage(
                  size: size, messageModel: message)),
        Padding(
          padding: EdgeInsets.only(top: size.width * .02),
          child: SizedBox(
              width: message.replayFileMessage != '' ||
                      message.replayContactMessage != ''
                  ? size.width * .7
                  : message.replayImageMessage != ''
                      ? size.width * .61
                      : size.width * .75,
              child: ReplayingMessageItemComponent(
                  messageModel: message,
                  size: size,
                  messageTextColor: messageTextColor,
                  width: size.width)),
        ),
      ],
    );
  }
}
