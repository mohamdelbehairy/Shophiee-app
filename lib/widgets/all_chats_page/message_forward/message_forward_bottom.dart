import 'package:app/constants.dart';
import 'package:app/cubit/forward/forward_selected_friend/forward_selected_friend_cubit.dart';
import 'package:app/cubit/forward/forward_selected_group/forward_selected_group_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/groups/groups_mdeia_fiels/group_store_media_files/group_store_media_files_cubit.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/media_files_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class MessageForwardButton extends StatefulWidget {
  const MessageForwardButton(
      {super.key, this.message, required this.user, this.mediaFiels});
  final MessageModel? message;
  final MediaFilesModel? mediaFiels;
  final UserModel user;

  @override
  State<MessageForwardButton> createState() => _MessageForwardButtonState();
}

class _MessageForwardButtonState extends State<MessageForwardButton> {
  bool isCircle = false;

  showToastMethod() {
    ShowToast(
        context: context,
        showToastText: 'Message forward successfully',
        position: StyledToastPosition.center);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var selectedFriend = context.read<ForwardSelectedFriendCubit>();
    var selectedGroup = context.read<ForwardSelectedGroupCubit>();
    var sendMessage = context.read<MessageCubit>();
    var sendGroupMessage = context.read<GroupMessageCubit>();
    var storeMedia = context.read<GroupStoreMediaFielsCubit>();

    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            final userData = state.userModel
                .firstWhere((element) => element.userID == currentUser.uid);
            return GestureDetector(
              onTap: () async {
                try {
                  setState(() {
                    isCircle = true;
                  });
                  if (selectedFriend.selectedFriendList.isNotEmpty) {
                    for (var friend in selectedFriend.selectedFriendList) {
                      if (widget.message != null) {
                        await sendMessage.sendMessage(
                            imageUrl: widget.message!.messageImage,
                            videoUrl: widget.message!.messageVideo,
                            fileUrl: widget.message!.messageFile,
                            audioUrl: widget.message!.messageSound,
                            audioName: widget.message!.messageSoundName,
                            audioTime: widget.message!.messageSoundTime,
                            recordUrl: widget.message!.messageRecord,
                            recordTime: widget.message!.messageRecordTime,
                            phoneContactName: widget.message!.phoneContactName,
                            phoneContactNumber:
                                widget.message!.phoneContactNumber,
                            messageFileName: widget.message!.messageFileName,
                            receiverID: friend.userID,
                            messageText: widget.message!.messageText,
                            userName: friend.userName,
                            profileImage: friend.profileImage,
                            userID: friend.userID,
                            myUserName: userData.userName,
                            myProfileImage: userData.profileImage,
                            friendNameReplay: '',
                            replayMessageID: '',
                            replayContactMessage: '',
                            replayFileMessage: '',
                            replayImageMessage: '',
                            replayTextMessage: '',
                            replayRecordMessage: '',
                            replaySoundMessage: '');
                      } else {
                        await sendMessage.sendMessage(
                            imageUrl: widget.mediaFiels!.messageImage,
                            videoUrl: widget.mediaFiels!.messageVideo,
                            // fileUrl: widget.message!.messageFile,
                            // audioUrl: widget.message!.messageSound,
                            // audioName: widget.message!.messageSoundName,
                            // audioTime: widget.message!.messageSoundTime,
                            // recordUrl: widget.message!.messageRecord,
                            // recordTime: widget.message!.messageRecordTime,
                            // phoneContactName: widget.message!.phoneContactName,
                            // phoneContactNumber:
                            //     widget.message!.phoneContactNumber,
                            // messageFileName: widget.message!.messageFileName,

                            messageText: widget.mediaFiels!.messageText != null
                                ? widget.mediaFiels!.messageText!
                                : '',
                            receiverID: friend.userID,
                            userName: friend.userName,
                            profileImage: friend.profileImage,
                            userID: friend.userID,
                            myUserName: userData.userName,
                            myProfileImage: userData.profileImage,
                            friendNameReplay: '',
                            replayMessageID: '',
                            replayContactMessage: '',
                            replayFileMessage: '',
                            replayImageMessage: '',
                            replayTextMessage: '',
                            replayRecordMessage: '',
                            replaySoundMessage: '');
                      }
                    }
                  }
                  if (selectedGroup.selectedGroupList.isNotEmpty) {
                    for (var group in selectedGroup.selectedGroupList) {
                      if (widget.message != null) {
                        await sendGroupMessage.sendGroupMessage(
                            groupID: group,
                            messageText: widget.message!.messageText,
                            imageUrl: widget.message!.messageImage,
                            videoUrl: widget.message!.messageVideo,
                            fileUrl: widget.message!.messageFile,
                            audioUrl: widget.message!.messageSound,
                            audioName: widget.message!.messageSoundName,
                            audioTime: widget.message!.messageSoundTime,
                            recordUrl: widget.message!.messageRecord,
                            recordTime: widget.message!.messageRecordTime,
                            messageFileName: widget.message!.messageFileName,
                            phoneContactName: widget.message!.phoneContactName,
                            phoneContactNumber:
                                widget.message!.phoneContactNumber,
                            friendNameReplay: '',
                            replayMessageID: '',
                            replayContactMessage: '',
                            replayFileMessage: '',
                            replayImageMessage: '',
                            replayTextMessage: '',
                            replayRecordMessage: '',
                            replaySoundMessage: '');
                        await storeMedia.storeMedia(
                          groupID: group,
                          messageText: widget.message!.messageText,
                          messageImage: widget.message!.messageImage,
                          messageVideo: widget.message!.messageVideo,
                        );
                        // await storeMedia.storeFiel(groupID: group,messageFile: ,messageFileName: ,messageFileSize: ,messageFileType: );
                      } else {
                        await sendGroupMessage.sendGroupMessage(
                            groupID: group,
                            messageText: widget.mediaFiels!.messageText != null
                                ? widget.mediaFiels!.messageText!
                                : '',
                            imageUrl: widget.mediaFiels!.messageImage,
                            videoUrl: widget.mediaFiels!.messageVideo,
                            // fileUrl: widget.message!.messageFile,
                            // audioUrl: widget.message!.messageSound,
                            // audioName: widget.message!.messageSoundName,
                            // audioTime: widget.message!.messageSoundTime,
                            // recordUrl: widget.message!.messageRecord,
                            // recordTime: widget.message!.messageRecordTime,
                            // messageFileName: widget.message!.messageFileName,
                            // phoneContactName: widget.message!.phoneContactName,
                            // phoneContactNumber:
                            //     widget.message!.phoneContactNumber,
                            friendNameReplay: '',
                            replayMessageID: '',
                            replayContactMessage: '',
                            replayFileMessage: '',
                            replayImageMessage: '',
                            replayTextMessage: '',
                            replayRecordMessage: '',
                            replaySoundMessage: '');
                        await storeMedia.storeMedia(
                            groupID: group,
                            messageText: widget.mediaFiels!.messageText != null
                                ? widget.mediaFiels!.messageText!
                                : '',
                            messageImage: widget.mediaFiels!.messageImage,
                            messageVideo: widget.mediaFiels!.messageVideo);
                        // await storeMedia.storeFiel(groupID: group,messageFile: ,messageFileName: ,messageFileSize: ,messageFileType: );
                      }
                    }
                  }
                  showToastMethod();
                } finally {
                  setState(() {
                    isCircle = false;
                  });
                  await selectedFriend.deleteAllSelectedFriends();
                  await selectedGroup.deleteAllSelectedGroups();
                }
              },
              child: CircleAvatar(
                radius: size.width * .08,
                backgroundColor: kPrimaryColor,
                child: isCircle
                    ? SizedBox(
                        height: size.width * .07,
                        width: size.width * .07,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Icon(Icons.send,
                        color: Colors.white, size: size.width * .07),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
