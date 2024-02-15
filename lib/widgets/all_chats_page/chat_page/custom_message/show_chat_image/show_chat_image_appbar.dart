import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/show_chat_image/show_chat_app_bar_pop_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowChatImageAppBar extends StatelessWidget {
  const ShowChatImageAppBar(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.senderID == FirebaseAuth.instance.currentUser!.uid)
              Text('You', style: TextStyle(fontSize: size.height * .02))
            else
              Text(user.userName.split(' ')[0],
                  style: TextStyle(fontSize: size.height * .02)),
            Text(
              message.showChatImageTime(),
              style: TextStyle(fontSize: size.width * .03),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: size.width * .01),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.share, size: size.width * .06),
              SizedBox(width: size.width * .01),
              ShowChatAppBarPopMenu(message: message),
            ],
          ),
        )
      ],
    );
  }
}
