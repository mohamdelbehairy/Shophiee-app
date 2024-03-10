import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/replay_message_text_component.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplayMessageText extends StatelessWidget {
  const ReplayMessageText(
      {super.key,
      required this.size,
      required this.messageModel,
      required this.messageTextColor});

  final Size size;
  final MessageModel messageModel;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (messageModel.messageImage == null)
          Container(
              height: size.height * .04,
              width: size.width * .005,
              color: messageModel.senderID ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? Colors.white
                  : Colors.grey),
        if (messageModel.replayImageMessage != '')
          SizedBox(width: size.width * .015),
        if (messageModel.replayImageMessage != '')
          Padding(
            padding: EdgeInsets.only(bottom: size.width * .01),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FancyShimmerImage(
                    boxFit: BoxFit.cover,
                    shimmerBaseColor:
                        isDark ? Colors.white12 : Colors.grey.shade300,
                    shimmerHighlightColor:
                        isDark ? Colors.white24 : Colors.grey.shade100,
                    imageUrl: messageModel.replayImageMessage!),
              ),
            ),
          ),
        if (messageModel.replayFileMessage != '')
          SizedBox(width: size.width * .015),
        if (messageModel.replayFileMessage != null &&
            messageModel.replayContactMessage == '' &&
            messageModel.replayImageMessage == '' &&
            messageModel.replayTextMessage == '')
          Padding(
              padding: EdgeInsets.only(bottom: size.width * .015),
              child: CircleAvatar(
                radius: size.width * .04,
                backgroundColor: messageModel.senderID ==
                        FirebaseAuth.instance.currentUser!.uid
                    ? Colors.white
                    : kPrimaryColor,
                child: Icon(Icons.insert_drive_file,
                    color: messageModel.senderID ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? kPrimaryColor
                        : Colors.white,
                    size: size.width * .045),
              )),
        if (messageModel.replayContactMessage != null &&
            messageModel.replayImageMessage == '' &&
            messageModel.replayFileMessage == '' &&
            messageModel.replayTextMessage == '')
          SizedBox(width: size.width * .015),
        if (messageModel.replayContactMessage != null &&
            messageModel.replayFileMessage == '' &&
            messageModel.replayTextMessage == '' &&
            messageModel.replayImageMessage == '')
          Padding(
              padding: EdgeInsets.only(bottom: size.width * .015),
              child: CircleAvatar(
                radius: size.width * .04,
                backgroundColor: messageModel.senderID ==
                        FirebaseAuth.instance.currentUser!.uid
                    ? Colors.white
                    : kPrimaryColor,
                child: Icon(Icons.contact_phone,
                    color: messageModel.senderID ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? kPrimaryColor
                        : Colors.white,
                    size: size.width * .045),
              )),
        if (messageModel.messageImage == null)
          ReplayMessageTextComponent(
              messageTextColor: messageTextColor,
              messageModel: messageModel,
              size: size),
      ],
    );
  }
}
