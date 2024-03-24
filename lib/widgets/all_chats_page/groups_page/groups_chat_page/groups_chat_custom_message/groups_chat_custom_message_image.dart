import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageImage extends StatelessWidget {
  const GroupsChatCustomMessageImage(
      {super.key, required this.user, required this.message});
  final UserModel user;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .4,
      width: size.width * .7,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          // topLeft: message.senderID == FirebaseAuth.instance.currentUser!.uid
          //     ? Radius.circular(message.replayTextMessage != '' ||
          //             message.replayImageMessage != '' ||
          //             message.replayFileMessage != '' ||
          //             message.replayContactMessage != ''
          //         ? 0
          //         : 24)
          //     : Radius.circular(0),
          bottomLeft: message.senderID == FirebaseAuth.instance.currentUser!.uid
              ? Radius.circular(24)
              : Radius.circular(0),
          topRight: message.senderID == FirebaseAuth.instance.currentUser!.uid
              ? Radius.circular(message.replayTextMessage != '' ||
                      message.replayImageMessage != '' ||
                      message.replayFileMessage != '' ||
                      message.replayContactMessage != ''
                  ? 0
                  : 24)
              : Radius.circular(0),
          bottomRight:
              message.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(0)
                  : Radius.circular(24),
        ),
        child: CachedNetworkImage(
          imageUrl: message.messageImage!,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
