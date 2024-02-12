import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet.dart';
import 'package:app/widgets/all_chats_page/chat_page/choose_item.dart';
import 'package:app/widgets/all_chats_page/chat_page/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomItemSendMesage extends StatefulWidget {
  const BottomItemSendMesage(
      {super.key,
      required this.controller,
      required this.user,
      required this.scrollController});
  final TextEditingController controller;
  final UserModel user;
  final ScrollController scrollController;

  @override
  State<BottomItemSendMesage> createState() => _BottomItemSendMesageState();
}

class _BottomItemSendMesageState extends State<BottomItemSendMesage> {
  bool isShowSendButton = false;
  @override
  Widget build(BuildContext context) {
    var message = context.read<MessageCubit>();
    return Padding(
      padding: EdgeInsets.only(bottom: 12, right: 12, left: 12),
      child: Row(
        children: [
          MessageTextField(
            controller: widget.controller,
            onChanged: (value) {
              setState(() {
                isShowSendButton = value.isNotEmpty;
              });
            },
            onPressed: () => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                builder: (context) => ChatBottomSheet()),
          ),
          GestureDetector(
              onTap: () async {
                if (isShowSendButton) {
                  await message.sendMessage(
                      receiverID: widget.user.userID,
                      messageText: widget.controller.text);
                  widget.controller.clear();
                  widget.scrollController.animateTo(0,
                      duration: const Duration(microseconds: 20),
                      curve: Curves.easeIn);
                  setState(() {
                    isShowSendButton = false;
                  });
                } else {}
              },
              child: CustomChooseItem(
                  icon: isShowSendButton ? Icons.send : Icons.mic)),
        ],
      ),
    );
  }
}
