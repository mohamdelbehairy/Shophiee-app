import 'package:app/constants.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/message_forward_page.dart';
import 'package:app/utils/save_sound.dart';
import 'package:app/utils/share_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<dynamic> customMessageShowMenu(
    {required BuildContext context,
    required Size size,
    required UserModel user,
    required MessageModel messages}) {
  var message = context.read<MessageCubit>();
  return showMenu(
    context: context,
    color: kPrimaryColor,
    position: RelativeRect.fromDirectional(
        textDirection: TextDirection.ltr,
        start: size.height * .1,
        top: size.height * .12,
        end: 0,
        bottom: 0),
    items: [
      if (messages.messageText == '')
        PopupMenuItem(
          onTap: () async {
            String? mediaUrl;
            String? mediaType;
            if (messages.messageImage != null) {
              mediaUrl = messages.messageImage!;
              mediaType = 'image.jpg';
            } else if (messages.messageVideo != null) {
              mediaUrl = messages.messageVideo!;
              mediaType = 'video.mp4';
            } else if (messages.messageFile != null) {
              mediaUrl = messages.messageFile!;
              mediaType = '${messages.messageFileName}';
            } else if (messages.phoneContactNumber != null) {
              mediaUrl = messages.phoneContactNumber!;
              mediaType = 'phone_number';
            } else if (messages.messageText != '') {
              mediaUrl = messages.messageText;
              mediaType = messages.messageText;
            } else if (messages.messageSound != null) {
              mediaUrl = messages.messageSound!;
              mediaType = '${messages.messageSoundName}';
            }
            if (mediaUrl != null && mediaType != null) {
              await shareMedia(mediaUrl: mediaUrl, mediaType: mediaType);
            }
          },
          child: Row(
            children: [
              Icon(Icons.share, size: size.height * .02, color: Colors.white),
              SizedBox(width: size.width * .04),
              Text("Share", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      if (messages.messageSound != null)
        PopupMenuItem(
            onTap: () async {
              await saveSound(messages: messages);
            },
            child: Row(
              children: [
                Icon(Icons.save, size: size.height * .018, color: Colors.white),
                SizedBox(width: size.width * .04),
                Text("Save", style: TextStyle(color: Colors.white)),
              ],
            )),
      if (messages.messageText.isNotEmpty)
        PopupMenuItem(
          onTap: () {
            final value = ClipboardData(text: messages.messageText);
            Clipboard.setData(value);
          },
          child: Row(
            children: [
              Icon(FontAwesomeIcons.copy,
                  size: size.height * .018, color: Colors.white),
              SizedBox(width: size.width * .04),
              Text("Copy", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      PopupMenuItem(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MessageForwardPage(user: user, message: messages)));
        },
        child: Row(
          children: [
            Icon(FontAwesomeIcons.share,
                size: size.height * .018, color: Colors.white),
            SizedBox(width: size.width * .04),
            Text("Forward", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      if (messages.messageText.isNotEmpty)
        PopupMenuItem(
            onTap: () {},
            child: Row(
              children: [
                Transform.rotate(
                  angle: .5,
                  child: Icon(Icons.push_pin_outlined,
                      size: size.height * .018, color: Colors.white),
                ),
                SizedBox(width: size.width * .04),
                Text("Pin", style: TextStyle(color: Colors.white)),
              ],
            )),
      if (messages.messageText.isNotEmpty)
        PopupMenuItem(
          onTap: () {},
          child: Row(
            children: [
              Icon(Icons.edit, size: size.height * .018, color: Colors.white),
              SizedBox(width: size.width * .04),
              Text("Edit", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      PopupMenuItem(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.blue[900]!.withOpacity(0.9),
                  title: const Text("Delete message",
                      style: TextStyle(color: Colors.white70)),
                  content: const Text(
                      "Are you sure wnt to delete this message?",
                      style: TextStyle(color: Colors.white70)),
                  actions: [
                    ElevatedButton(
                      child: const Text(
                        "Cancel",
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    ElevatedButton(
                      child: const Text("Delete"),
                      onPressed: () async {
                        Navigator.of(context).pop(false);

                        await message.deleteMessage(
                            friendID: user.userID,
                            messageID: messages.messageID);
                      },
                    ),
                  ],
                );
              });
        },
        child: Row(
          children: [
            Icon(FontAwesomeIcons.trash,
                size: size.height * .018, color: Colors.white),
            SizedBox(width: size.width * .04),
            Text("Delete", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    ],
  );
}
