import 'package:app/constants.dart';
import 'package:app/models/users_model.dart';
import 'package:app/refactory/chat_page_refactory/widgets/chat_page_body_refactory.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_app_bar_title.dart';
import 'package:app/widgets/all_chats_page/chat_page/chats_icons_app_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPageRefactory extends StatelessWidget {
  const ChatPageRefactory({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: ChatPageAppBarTitle(user: user),
        iconTheme: IconThemeData(size: 35, color: Colors.white),
        actions: [
          ChatsIconsAppBarButton(icon: Icons.call),
          ChatsIconsAppBarButton(icon: FontAwesomeIcons.video),
          ChatsIconsAppBarButton(icon: Icons.error),
        ],
      ),
      body: SafeArea(child: ChatPageBodyRefactory(user: user, size: size)),
    );
  }
}
