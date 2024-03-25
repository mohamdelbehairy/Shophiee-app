import 'package:app/constants.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageFileBody extends StatelessWidget {
  const GroupsChatCustomMessageFileBody(
      {super.key,
      required this.size,
      required this.pickFile,
      required this.message});

  final Size size;
  final PickFileCubit pickFile;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: size.width * .005),
          GestureDetector(
            onTap: () async {
              await pickFile.downloadAndOpenFile(
                  fileUrl: message.messageFile!,
                  fileName: message.messageFileName!);
            },
            child: CircleAvatar(
              radius: size.width * .04,
              backgroundColor:
                  message.senderID == FirebaseAuth.instance.currentUser!.uid
                      ? Colors.white
                      : kPrimaryColor,
              child: Icon(Icons.insert_drive_file,
                  color:
                      message.senderID == FirebaseAuth.instance.currentUser!.uid
                          ? kPrimaryColor
                          : Colors.white,
                  size: size.width * .045),
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
    );
  }
}
