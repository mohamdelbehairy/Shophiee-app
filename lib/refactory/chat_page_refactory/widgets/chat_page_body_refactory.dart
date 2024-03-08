import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/message/message_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_refactory_list_view.dart';
import 'package:app/refactory/chat_page_refactory/widgets/custom_send_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBodyRefactory extends StatefulWidget {
  const ChatPageBodyRefactory(
      {super.key, required this.user, required this.size});

  final UserModel user;
  final Size size;

  @override
  State<ChatPageBodyRefactory> createState() => _ChatPageBodyRefactoryState();
}

class _ChatPageBodyRefactoryState extends State<ChatPageBodyRefactory> {
  final scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
   bool isSwip = false;
  MessageModel? messageModel;
  late FocusNode focusNode;
  @override
  void initState() {
    context.read<MessageCubit>().getMessage(receiverID: widget.user.userID);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.read<MessageCubit>();
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) async {
        if (state is DeleteMessageSuccess) {
          if (await messages.isChatsEmpty(friendID: widget.user.userID)) {
            messages.deleteChat(
                friendID: widget.user.lastMessage?['lastUserID']);
          }
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            ChatPageRefacoryListView(
                onLeftSwipe: (details) {},
                user: widget.user,
                size: widget.size,
                scrollController: scrollController),
            CustomSendItems(
                user: widget.user,
                scrollController: scrollController,
                size: widget.size,
                textEditingController: textEditingController),
          ],
        );
      },
    );
  }
}
