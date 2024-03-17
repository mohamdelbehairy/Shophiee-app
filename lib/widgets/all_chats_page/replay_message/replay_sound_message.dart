import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/item_image_replaying_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/replaying_message_item_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplaySoundMessage extends StatelessWidget {
  const ReplaySoundMessage(
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
            height: size.height * .04,
            width: size.width * .005,
            margin:
                EdgeInsets.only(top: size.width * .02, left: size.width * .04),
            color: message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Colors.white
                : Colors.grey),
        if (message.replayImageMessage != null)
          Padding(
            padding:
                EdgeInsets.only(top: size.width * .025, left: size.width * .02),
            child: ItemImageReplayingMessage(
                size: size, isDark: isDark, message: message),
          ),
        Padding(
          padding: EdgeInsets.only(top: size.width * .02),
          child: SizedBox(
              // width: message.replayTextMessage != '' ||
              //         message.replayImageMessage != ''
              //     ? size.width * .35
              //     : message.replayFileMessage != ''
              //         ? size.width * .45
              //         : message.replayContactMessage != ''
              //             ? size.width * .35
              //             : 0.0,
              width: size.width * .35,
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
