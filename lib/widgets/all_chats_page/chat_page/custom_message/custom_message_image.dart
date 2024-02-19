import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomMessageImage extends StatelessWidget {
  const CustomMessageImage(
      {super.key, required this.message, required this.isSeen});
  final MessageModel message;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
    );
  }
}
