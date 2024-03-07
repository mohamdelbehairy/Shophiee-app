import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/refactory_message/message_date.dart';
import 'package:app/refactory_message/message_text/image_message.dart';
import 'package:app/refactory_message/message_text/text_message.dart';
import 'package:app/pages/chats/show_chat_image_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;

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
              width: message.messageImage != null
                  ? null
                  : message.messageText.length <= 5
                      ? size.width * .15
                      : message.messageText.length > 50
                          ? size.width * .8
                          : null,
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * .03, vertical: size.width * .003),
              padding: EdgeInsets.only(
                  right: message.messageImage != null ? 0.0 : size.width * .01),
              decoration: BoxDecoration(
                  color:
                      message.messageImage != null && message.messageText == ''
                          ? Colors.transparent
                          : backGroundMessageColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                        message.messageText.length <= 100 ? 16 : 24),
                    topLeft: Radius.circular(message.receiverID ==
                                FirebaseAuth.instance.currentUser!.uid &&
                            message.messageText.length <= 100
                        ? 16
                        : 24),
                    bottomRight: Radius.circular(message.senderID !=
                            FirebaseAuth.instance.currentUser!.uid
                        ? 24
                        : 0),
                    bottomLeft: Radius.circular(message.senderID !=
                            FirebaseAuth.instance.currentUser!.uid
                        ? 0
                        : 24),
                  )),
              child: Column(
                crossAxisAlignment:
                    message.messageImage != null && message.messageText != ''
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                children: [
                  if (message.messageImage != null && message.messageText == '')
                    ImageMessage(size: size, messageModel: message),
                  if (message.messageImage != null && message.messageText != '')
                    ImageMessage(size: size, messageModel: message),
                  if (message.messageText != '')
                    MessageText(
                        size: size,
                        messageModel: message,
                        messageTextColor: messageTextColor),
                ],
              ),
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
          MessageDate(size: size, message: message, isSeen: isSeen),
        ],
      ),
    );
  }
}
