import 'package:app/constants.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/message/message_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet.dart';
import 'package:app/widgets/all_chats_page/chat_page/choose_item.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/emoji_widget.dart';
import 'package:app/widgets/all_chats_page/chat_page/text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  bool emojiShow = false;
  TextEditingController controller = TextEditingController();
  bool isShowSendButton = false;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MessageCubit>().getMessage(receiverID: widget.user.userID);
  }

  @override
  Widget build(BuildContext context) {
    final message = context.read<MessageCubit>();
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
                    itemCount: message.messages.length,
                    itemBuilder: (context, index) {
                      var message =
                          context.read<MessageCubit>().messages[index];
                      return CustomMessage(
                        message: message,
                        bottomLeft: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Radius.circular(
                                size.width * .038,
                              )
                            : Radius.circular(
                                0,
                              ),
                        bottomRight: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Radius.circular(
                                0,
                              )
                            : Radius.circular(
                                size.width * .038,
                              ),
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
                            : Colors.black,
                      );
                    })),
            if (emojiShow) CustomEmojiWidget(addEmoji: addEmoji),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: [
                    MessageTextField(
                      emojiShow: emojiShow,
                      controller: controller,
                      onTap: () {
                        setState(() {
                          emojiShow = false;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          isShowSendButton = value.isNotEmpty;
                        });
                      },
                      onPressed: () async {
                        if (emojiShow) {
                          emojiShow = false;
                          setState(() {});
                          await Future.delayed(Duration(milliseconds: 500))
                              .then((value) async {
                            await SystemChannels.textInput
                                .invokeMethod('TextInput.show');
                          });
                        } else {
                          await SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          emojiShow = true;
                          setState(() {});
                        }
                      },
                    ),
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (isShowSendButton) {
                            await message.sendMessage(
                                receiverID: widget.user.userID,
                                messageText: controller.text);
                            controller.clear();
                            _controller.animateTo(0,
                                duration: const Duration(microseconds: 20),
                                curve: Curves.easeIn);
                            setState(() {
                              isShowSendButton = false;
                            });
                          } else {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => ChatBottomSheet());
                          }
                        },
                        child: CustomChooseItem(
                            icon: isShowSendButton ? Icons.send : Icons.add)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  addEmoji({required Emoji emoji}) {
    controller.text = controller.text + emoji.emoji;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    setState(() {});
  }
}
