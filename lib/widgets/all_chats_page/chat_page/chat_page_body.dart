import 'package:app/constants.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet.dart';
import 'package:app/widgets/all_chats_page/chat_page/choose_item.dart';
import 'package:app/widgets/all_chats_page/chat_page/emoji_widget.dart';
import 'package:app/widgets/all_chats_page/chat_page/text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({super.key});

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  bool emojiShow = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.only(
                  left: 16, right: 32, top: 16, bottom: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  color: kPrimaryColor),
              child: Text(
                'محمد ابراهيم البحيري',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        if (emojiShow) CustomEmojiWidget(addEmoji: addEmoji),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => CustomBottomSheet());
                    },
                    child: CustomChooseItem()),
                CustomTextFieldChatItem(
                  emojiShow: emojiShow,
                  textEditingController: textEditingController,
                  onTap: () {
                    setState(() {
                      emojiShow = false;
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  addEmoji({required Emoji emoji}) {
    textEditingController.text = textEditingController.text + emoji.emoji;
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
    setState(() {});
  }
}
