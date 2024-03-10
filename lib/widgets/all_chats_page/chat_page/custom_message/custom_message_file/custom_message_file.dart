import 'package:app/constants.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/custom_message_file_replay_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageFile extends StatelessWidget {
  const CustomMessageFile(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pickFile = context.read<PickFileCubit>();
    return Container(
      width: size.width * .56,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.replayTextMessage != '' ||
              message.replayImageMessage != '' ||
              message.replayFileMessage != '')
            CustomMessageFileReplayFile(message: message, user: user),
          SizedBox(height: size.height * .005),
          Row(
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
                      color: message.senderID ==
                              FirebaseAuth.instance.currentUser!.uid
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
        ],
      ),
    );
  }
}
