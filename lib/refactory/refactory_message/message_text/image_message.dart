import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageMessageRefactory extends StatelessWidget {
  const ImageMessageRefactory(
      {super.key, required this.messageModel, required this.size});
  final MessageModel messageModel;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .7,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(24)
                  : Radius.circular(0),
          bottomLeft:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(24)
                  : Radius.circular(0),
          topRight:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(0)
                  : Radius.circular(24),
          bottomRight:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(0)
                  : Radius.circular(24),
        ),
        child: CachedNetworkImage(
          imageUrl: messageModel.messageImage!,
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
