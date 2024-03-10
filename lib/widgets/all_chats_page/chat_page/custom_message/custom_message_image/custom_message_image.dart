import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomMessageImage extends StatelessWidget {
  const CustomMessageImage(
      {super.key,
      required this.message,
      required this.user,
      required Size size});
  final MessageModel message;

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * .7,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft:
                  message.senderID == FirebaseAuth.instance.currentUser!.uid
                      ? Radius.circular(24)
                      : Radius.circular(0),
              bottomLeft:
                  message.senderID == FirebaseAuth.instance.currentUser!.uid
                      ? Radius.circular(24)
                      : Radius.circular(0),
              topRight:
                  message.senderID == FirebaseAuth.instance.currentUser!.uid
                      ? Radius.circular(0)
                      : Radius.circular(24),
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
        )
      ],
    );
  }
}
