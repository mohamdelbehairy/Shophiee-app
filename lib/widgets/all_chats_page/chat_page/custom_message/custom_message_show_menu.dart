import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> customMessageShowMenue(
    {required BuildContext context,
    required Size size,
    required UserModel user,
    required MessageModel messages}) {
  var message = context.read<MessageCubit>();
  return showMenu(
    context: context,
    position: RelativeRect.fromDirectional(
        textDirection: TextDirection.ltr,
        start: size.height * .1,
        top: size.height * .12,
        end: 0,
        bottom: 0),
    items: [
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
        child: Text("Delete"),
      ),
      PopupMenuItem(
        onTap: () {},
        child: Text("Delete"),
      ),
      PopupMenuItem(
        onTap: () {},
        child: Text("Delete"),
      ),
    ],
  );
}
