import 'package:app/constants.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatCustomMessageFile extends StatelessWidget {
  const GroupsChatCustomMessageFile({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pickFile = context.read<PickFileCubit>();
    return Container(
      height: message.messageText == ''
          ? size.height * .06
          : message.messageText.length > 29
          ? size.height * .21
          : size.height * .07,
      width: size.width * .56,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  await pickFile.downloadAndOpenFile(
                      fileUrl: message.messageFile!,
                      fileName: message.messageFileName!);
                },
                child: CircleAvatar(
                  radius: size.width * .042,
                  backgroundColor:
                  message.senderID == FirebaseAuth.instance.currentUser!.uid
                      ? Colors.white
                      : kPrimaryColor,
                  child: Icon(Icons.insert_drive_file,
                      color: message.senderID ==
                          FirebaseAuth.instance.currentUser!.uid
                          ? kPrimaryColor
                          : Colors.white,
                      size: size.width * .05),
                ),
              ),
              SizedBox(width: size.width * .02),
              Expanded(
                child: Text(message.messageFileName!,
                    style: TextStyle(
                        color: message.senderID ==
                            FirebaseAuth.instance.currentUser!.uid
                            ? Colors.white
                            : Colors.black),
                    maxLines: null,
                    overflow: TextOverflow.visible),
              ),
            ],
          ),
          if (message.messageText != '')
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    right: message.messageText.length < 29 &&
                        message.messageText.length > 20
                        ? size.width * .12
                        : 0),
                child: Text(message.messageText,
                    maxLines: message.messageText.length < 29 &&
                        message.messageText.length > 20
                        ? 1
                        : 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: size.width * .04,
                        color: message.senderID ==
                            FirebaseAuth.instance.currentUser!.uid
                            ? Colors.white
                            : Colors.black)),
              ),
            )
        ],
      ),
    );
  }
}
