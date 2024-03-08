import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_refactory_list_view_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatPageRefacoryListView extends StatelessWidget {
  const ChatPageRefacoryListView({
    super.key,
    required this.user,
    required this.size,
    required this.scrollController, required this.onLeftSwipe,
  });

  final UserModel user;
  final Size size;
  final ScrollController scrollController;
  final Function(DragUpdateDetails) onLeftSwipe;

  @override
  Widget build(BuildContext context) {
    final messages = context.read<MessageCubit>();
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: messages.messages.length,
        itemBuilder: (context, index) {
          var message = context.read<MessageCubit>().messages[index];
          if (!message.isSeen &&
              message.senderID != FirebaseAuth.instance.currentUser!.uid) {
            messages.updateChatMessageSeen(
                receiverID: user.userID, messageID: message.messageID);
          }
          return SwipeTo(
            onLeftSwipe: onLeftSwipe,
            key: Key(message.messageID),
            child: ChatPageRecactoryListViewItem(
                user: user, message: message, size: size),
          );
        },
      ),
    );
  }
}
