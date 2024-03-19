import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/pages/chats/show_chat_image_page.dart';
import 'package:app/pages/my_friend_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/message_date_time.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupsChatCustomMessage extends StatelessWidget {
  const GroupsChatCustomMessage(
      {super.key,
      required this.message,
      required this.alignment,
      required this.backGroundMessageColor,
      required this.bottomLeft,
      required this.bottomRight,
      required this.messageTextColor,
      required this.isSeen});
  final MessageModel message;
  final Alignment alignment;

  final Color backGroundMessageColor;
  final Radius bottomLeft;
  final Radius bottomRight;
  final Color messageTextColor;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = message.senderID;
          final data = state.userModel
              .firstWhere((element) => element.userID == currentUser);
          return GestureDetector(
            onTap: () async {
              if (message.messageImage != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowChatImagePage(message: message, user: data)));
              }
              if (message.phoneContactNumber != null) {
                String url = 'tel:${message.phoneContactNumber}';
                if (await canLaunchUrl(Uri(scheme: 'tel', path: url))) {
                  await launchUrl(Uri(scheme: 'tel', path: url));
                } else {
                  print('error');
                }
              }
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    GroupsChatCustomMessageDetails(
                        message: message,
                        user: data,
                        alignment: alignment,
                        messageTextColor: messageTextColor,
                        bottomLeft: bottomLeft,
                        bottomRight: bottomRight,
                        isSeen: isSeen,
                        backGroundMessageColor: backGroundMessageColor),
                    MessageDateTime(
                        size: size, message: message, isSeen: isSeen),
                  ],
                ),
                if (message.senderID != FirebaseAuth.instance.currentUser!.uid)
                  Positioned(
                    top: size.height * .005,
                    left: size.width * .02,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFriendPage(user: data))),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(data.profileImage),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
