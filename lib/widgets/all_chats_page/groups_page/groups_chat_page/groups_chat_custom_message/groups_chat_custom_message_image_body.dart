import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageImageBody extends StatelessWidget {
  const GroupsChatCustomMessageImageBody(
      {super.key, required this.size, required this.message});

  final Size size;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height * .4,
      width: size.width * .75,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Radius.circular(message.replayTextMessage != '' ||
                        message.replayImageMessage != '' ||
                        message.replayFileMessage != '' ||
                        message.replayContactMessage != '' ||
                        message.replaySoundMessage != '' ||
                        message.replayRecordMessage != ''
                    ? 0
                    : 24)
                : Radius.circular(4),
            bottomLeft:
                message.senderID == FirebaseAuth.instance.currentUser!.uid
                    ? Radius.circular(24)
                    : Radius.circular(24),
            topRight: message.senderID == FirebaseAuth.instance.currentUser!.uid
                ? Radius.circular(message.replayTextMessage != '' ||
                        message.replayImageMessage != '' ||
                        message.replayFileMessage != '' ||
                        message.replayContactMessage != ''
                    ? 0
                    : 0)
                : Radius.circular(30),
            bottomRight:
                message.senderID == FirebaseAuth.instance.currentUser!.uid
                    ? Radius.circular(0)
                    : Radius.circular(30)),
        child: CachedNetworkImage(
          imageUrl: message.messageImage!,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                  color: message.messageText == ''
                      ? kPrimaryColor
                      : Colors.white)),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
