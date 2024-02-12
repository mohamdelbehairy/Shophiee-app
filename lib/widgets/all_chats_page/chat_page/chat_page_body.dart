import 'package:app/constants.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/message/message_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_item_send_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MessageCubit>().getMessage(receiverID: widget.user.userID);
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.read<MessageCubit>();
    final size = MediaQuery.of(context).size;
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                itemCount: messages.messages.length,
                itemBuilder: (context, index) {
                  var message = context.read<MessageCubit>().messages[index];
                  return CustomMessage(
                      message: message,
                      bottomLeft: message.senderID ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Radius.circular(size.width * .03)
                          : Radius.circular(0),
                      bottomRight: message.senderID ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Radius.circular(0)
                          : Radius.circular(size.width * .03),
                      alignment: message.senderID ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      backGroundMessageColor: message.senderID ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? kPrimaryColor
                          : Color(0xffe8f8f8),
                      messageTextColor: message.senderID ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Colors.white
                          : Colors.black);
                },
              ),
            ),
            BottomItemSendMesage(
              controller: controller,
              scrollController: _controller,
              user: widget.user,
            ),
          ],
        );
      },
    );
  }
}
