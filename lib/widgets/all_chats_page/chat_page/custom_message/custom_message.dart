import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_image/custom_message_image.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_contact.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/custom_message_file.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_show_date_time_icon.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_text.dart';
import 'package:app/pages/chats/show_chat_image_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_message_show_menu.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage(
      {super.key,
      required this.message,
      required this.backGroundMessageColor,
      required this.messageTextColor,
      required this.alignment,
      required this.bottomLeft,
      required this.bottomRight,
      required this.isSeen,
      required this.user});
  final MessageModel message;
  final Color backGroundMessageColor;
  final Color messageTextColor;
  final Alignment alignment;
  final Radius bottomLeft;
  final Radius bottomRight;
  final bool isSeen;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    int differenceInMinutes =
        Timestamp.now().toDate().difference(message.messageDateTime).inMinutes;
    int differenceInHours =
        Timestamp.now().toDate().difference(message.messageDateTime).inHours;
    int differenceInDays =
        Timestamp.now().toDate().difference(message.messageDateTime).inDays;

    final size = MediaQuery.of(context).size;
    final lastMessagePerUser = <String, MessageModel>{};
    final messages = context.watch<MessageCubit>().messages;
    for (final message in messages) {
      if (!lastMessagePerUser.containsKey(message.senderID)) {
        lastMessagePerUser[message.senderID] = message;
      }
    }

    final isLastMessage = lastMessagePerUser[message.senderID] == message;

    return GestureDetector(
      onLongPress: () => customMessageShowMenu(
          context: context, size: size, user: user, messages: message),
      onTap: () async {
        if (message.messageImage != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ShowChatImagePage(message: message, user: user)));
        }
        if (message.phoneContactNumber != null) {
          String url = 'tel:${message.phoneContactNumber}';

          if (await canLaunchUrl(Uri(scheme: 'tel', path: url))) {
            await launchUrl(Uri(scheme: 'tel', path: url));
          } else {
            print('error');
          }
        }
      },
      child: Column(
        children: [
          Align(
            alignment: alignment,
            child: Container(
              width: message.messageText.length > 70
                  ? size.width * .8
                  : message.messageText.length <= 5
                      ? size.width * .15
                      : message.messageText.length <= 25
                          ? size.width * .32
                          : size.width * .56,
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * .03, vertical: size.width * .003),
              padding: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                  color: backGroundMessageColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                          message.messageText.length >= 25 ? 0 : 24),
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24))),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: size.height * .015,
                      bottom: size.height * .015,
                      left: size.width * .032,
                      right: message.messageText.length > 50 ? 4 : 0),
                  child: Text(message.messageText,
                      style: TextStyle(color: messageTextColor))),
            ),
            //   Container(
            //     width: message.messageText.startsWith('http') ||
            //             message.messageText.startsWith('https')
            //         ? size.width * .6
            //         : message.messageFile != null && message.messageText != ''
            //             ? size.width * .6
            //             : message.messageImage != null
            //                 ? size.width * .6
            //                 : message.messageText.length > 25
            //                     ? size.width * .5
            //                     : null,
            //     margin: EdgeInsets.symmetric(
            //         horizontal: size.width * .03, vertical: size.width * .003),
            //     padding: EdgeInsets.all(
            //         message.messageImage != null || message.messageVideo != null
            //             ? size.width * .01
            //             : size.width * .02),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(message.messageImage != null ||
            //                     message.messageVideo != null
            //                 ? size.width * .01
            //                 : size.width * .03),
            //             topRight: Radius.circular(message.messageImage != null ||
            //                     message.messageVideo != null
            //                 ? size.width * .01
            //                 : size.width * .03),
            //             bottomLeft: message.messageImage != null ||
            //                     message.messageVideo != null
            //                 ? Radius.circular(size.width * .01)
            //                 : bottomLeft,
            //             bottomRight: message.messageImage != null ||
            //                     message.messageVideo != null
            //                 ? Radius.circular(size.width * .01)
            //                 : bottomRight),
            //         color: backGroundMessageColor),
            //     child: Stack(
            //       children: [
            //         Column(
            //           children: [
            //             if (message.messageVideo != null)
            //               CustomMessageVideo(message: message, user: user),
            //             if (message.phoneContactNumber != null)
            //               CustomMessageContact(message: message),
            //             if (message.messageFile != null)
            //               CustomMessageFile(message: message,user: user),
            //             if (message.messageImage != null)
            //               CustomMessageImage(
            //                   message: message, isSeen: isSeen, user: user),
            //             message.messageImage != null && message.messageText == ''
            //                 ? Padding(padding: EdgeInsets.all(0))
            //                 : message.messageVideo != null &&
            //                         message.messageText == ''
            //                     ? Padding(padding: EdgeInsets.all(0))
            //                     : CustomMessageText(
            //                         user: user,
            //                         message: message,
            //                         messageTextColor: messageTextColor)
            //           ],
            //         ),
            //         Positioned(
            //           bottom:
            //               message.messageImage != null || message.messageVideo != null
            //                   ? size.width * .005
            //                   : 0.0,
            //           right:
            //               message.messageImage != null || message.messageVideo != null
            //                   ? size.width * .005
            //                   : 0.0,
            //           child: CustomMessageShowDataTimeIcons(
            //               message: message,
            //               isSeen: isSeen,
            //               messageTextColor: messageTextColor),
            //         )
            //       ],
            //     ),
            //   ),
          ),
          // if (isLastMessage || user.userID != message.senderID)
          RefactoryCustomMessageText(
              size: size,
              message: message,
              isSeen: isSeen,
              differenceInMinutes: differenceInMinutes,
              differenceInHours: differenceInHours,
              differenceInDays: differenceInDays),
        ],
      ),
    );
  }
}

class RefactoryCustomMessageText extends StatelessWidget {
  const RefactoryCustomMessageText({
    super.key,
    required this.size,
    required this.message,
    required this.isSeen,
    required this.differenceInMinutes,
    required this.differenceInHours,
    required this.differenceInDays,
  });

  final Size size;
  final MessageModel message;
  final bool isSeen;
  final int differenceInMinutes;
  final int differenceInHours;
  final int differenceInDays;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * .03,
          right: size.width * .03,
          bottom: size.width * .01),
      child: Row(
        mainAxisAlignment:
            message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          if (message.senderID == FirebaseAuth.instance.currentUser!.uid)
            Text(isSeen ? 'Seen' : 'Send',
                style: TextStyle(color: Colors.grey)),
          SizedBox(width: size.width * .005),
          if (message.senderID == FirebaseAuth.instance.currentUser!.uid)
            Text('.', style: TextStyle(color: Colors.black)),
          SizedBox(width: size.width * .005),
          Text(
              differenceInMinutes < 1
                  ? 'now'
                  : differenceInMinutes < 60
                      ? '$differenceInMinutes m'
                      : differenceInHours < 24
                          ? '$differenceInHours h'
                          : differenceInDays < 7
                              ? differenceInDays == 1
                                  ? '$differenceInDays d'
                                  : ''
                              : '',
              style: TextStyle(color: Colors.grey)),
          if (message.senderID != FirebaseAuth.instance.currentUser!.uid)
            SizedBox(width: size.width * .01),
          if (message.senderID != FirebaseAuth.instance.currentUser!.uid)
            Icon(Icons.sms, color: Colors.grey, size: size.width * .04)
        ],
      ),
    );
  }
}
