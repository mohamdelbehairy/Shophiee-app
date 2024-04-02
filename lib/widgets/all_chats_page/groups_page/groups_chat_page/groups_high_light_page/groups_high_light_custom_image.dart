import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_image/replay_message_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupsHighLightCustomImage extends StatelessWidget {
  const GroupsHighLightCustomImage(
      {super.key, required this.message, required this.size});

  final MessageModel message;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (message.replayTextMessage != '' ||
            message.replayImageMessage != '' ||
            message.replayFileMessage != '' ||
            message.replayContactMessage != '' ||
            message.replaySoundMessage != '' ||
            message.replayRecordMessage != '')
          ReplayMessageImage(
              message: message,
              size: size,
              backgroungMessage: kPrimaryColor,
              messageColor: Colors.white),
        Container(
          // height: size.height * .4,
          width: size.width * .75,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
                imageUrl: message.messageImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(color: kPrimaryColor)),
                errorWidget: (context, url, error) => Icon(Icons.error)),
          ),
        ),
      ],
    );
  }
}
