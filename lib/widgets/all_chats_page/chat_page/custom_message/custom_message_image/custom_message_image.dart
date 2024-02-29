import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_image/custom_message_image_replay_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomMessageImage extends StatelessWidget {
  const CustomMessageImage(
      {super.key,
      required this.message,
      required this.isSeen,
      required this.user});
  final MessageModel message;
  final bool isSeen;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        if (message.replayTextMessage! != '' ||
            message.replayImageMessage != '' ||
            message.replayFileMessage != '' ||
            message.replayContactMessage != '')
          CustomMessageImageReplayImage(message: message, user: user),
        SizedBox(
            height: message.replayTextMessage != '' ||
                    message.replayImageMessage != '' ||
                    message.replayFileMessage != '' ||
                    message.replayContactMessage != ''
                ? size.width * .02
                : 0.0),
        Container(
          width: size.width * .6,
          height: size.width * .7,
          child: CachedNetworkImage(
            imageUrl: message.messageImage!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                  color:
                      message.senderID == FirebaseAuth.instance.currentUser!.uid
                          ? Colors.white
                          : kPrimaryColor),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ],
    );
  }
}
