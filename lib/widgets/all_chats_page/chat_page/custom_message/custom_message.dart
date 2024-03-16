import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/message_date_time.dart';
import 'package:app/pages/chats/show_chat_image_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_message_show_menu.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage({
    super.key,
    required this.message,
    required this.backGroundMessageColor,
    required this.messageTextColor,
    required this.alignment,
    required this.bottomLeft,
    required this.bottomRight,
    required this.isSeen,
    required this.user,
  });
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
        crossAxisAlignment:
            message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: [
          CustomMessageDetails(
              alignment: alignment,
              message: message,
              size: size,
              backGroundMessageColor: backGroundMessageColor,
              user: user,
              messageTextColor: messageTextColor),
          MessageDateTime(size: size, message: message, isSeen: isSeen),
        ],
      ),
    );
  }
}
