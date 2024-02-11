import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFieldChatItem extends StatelessWidget {
  const CustomTextFieldChatItem({super.key, required this.emojiShow, required this.onTap, required this.onPressed,required this.textEditingController});
  final bool emojiShow;
  final Function() onTap;
  final Function() onPressed;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: textEditingController,
          cursorColor: const Color(0xff2b2c33),
          maxLines: null,
          onTap: onTap,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: const Color(0xff2b2c33).withOpacity(.1),
                  )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(
                  color: const Color(0xff2b2c33).withOpacity(.1),
                ),
              ),
              filled: true,
              fillColor: const Color(0xff2b2c33).withOpacity(.1),
              hintText: 'Type your message',
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                  onPressed: onPressed,
                  icon: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      emojiShow ? Icons.keyboard : Icons.emoji_emotions,
                      color: kPrimaryColor,
                    ),
                  ))),
        ),
      ),
    );
  }
}
