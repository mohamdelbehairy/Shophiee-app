import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_contact_replaying_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_file_replaying_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_image_replaying_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../replaying_message_item_component.dart';

class ReplayMessageImage extends StatelessWidget {
  const ReplayMessageImage(
      {super.key,
      required this.size,
      required this.message,
      required this.backgroungMessage,
      required this.messageColor});
  final Size size;
  final MessageModel message;
  final Color backgroungMessage;
  final Color messageColor;

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    return Container(
      width: size.width * .7,
      padding: EdgeInsets.only(top: size.width * .03, bottom: size.width * .02),
      decoration: BoxDecoration(
        color: backgroungMessage,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
              message.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? 20
                  : 0.0),
          topRight: Radius.circular(
              message.senderID != FirebaseAuth.instance.currentUser!.uid
                  ? 20
                  : 0.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: size.width * .03),
          Container(
              height: size.height * .04,
              width: size.width * .005,
              color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Colors.white
                  : Colors.grey),
          if (message.replayImageMessage != '')
            SizedBox(width: size.width * .015),
          if (message.replayImageMessage != '')
            ItemImageReplayingMessage(
                size: size, isDark: isDark, message: message),
          if (message.replayFileMessage != '')
            SizedBox(width: size.width * .015),
          if (message.replayFileMessage != null &&
              message.replayContactMessage == '' &&
              message.replayImageMessage == '' &&
              message.replayTextMessage == '')
            ItemsFileReplayingMessage(size: size, message: message),
          if (message.replayContactMessage != '')
            SizedBox(width: size.width * .015),
          if (message.replayContactMessage != '')
            ItemContactReplayingMessage(size: size, messageModel: message),
          ReplayingMessageItemComponent(
              messageModel: message, size: size, messageTextColor: messageColor)
        ],
      ),
    );
  }
}
