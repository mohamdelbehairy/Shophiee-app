import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_contact_replaying_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_file_replaying_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_image_replaying_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/replaying_message_item_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplayMessageFile extends StatelessWidget {
  const ReplayMessageFile(
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
    return Padding(
      padding: EdgeInsets.only(top: size.width * .02),
      child: Row(
        children: [
          Container(
              height: size.height * .04,
              width: size.width * .005,
              margin: EdgeInsets.only(left: size.width * .015),
              color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Colors.white
                  : Colors.grey),
          if (message.replayImageMessage != '')
            SizedBox(width: size.width * .015),
          if (message.replayImageMessage != '')
            ItemImageReplayingMessage(
                size: size, isDark: isDark, message: message),
          if (message.replayContactMessage != '')
            SizedBox(width: size.width * .015),
          if (message.replayContactMessage != '')
            Padding(
                padding: EdgeInsets.only(
                    bottom: message.replayContactMessage != ''
                        ? size.width * .01
                        : 0.0),
                child: ItemContactReplayingMessage(
                    size: size, messageModel: message)),
          if (message.replayFileMessage != '')
            SizedBox(width: size.width * .015),
          if (message.replayFileMessage != '')
            ItemsFileReplayingMessage(size: size, message: message),
          Padding(
            padding: EdgeInsets.only(
                bottom: message.replayContactMessage != ''
                    ? size.width * .01
                    : 0.0),
            child: ReplayingMessageItemComponent(
                width: size.width * .4,
                messageModel: message,
                size: size,
                messageTextColor: messageTextColor),
          ),
        ],
      ),
    );
  }
}
