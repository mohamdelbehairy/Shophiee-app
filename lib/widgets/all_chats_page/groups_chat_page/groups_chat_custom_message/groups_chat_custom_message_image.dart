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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.senderID != FirebaseAuth.instance.currentUser!.uid &&
            message.messageImage != null)
          Text(user.userName,
              style: TextStyle(
                  fontSize: size.width * .04,
                  color: Colors.blue,
                  fontWeight: FontWeight.normal)),
        Container(
          width: size.width * .45,
          height: size.width * .45,
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
