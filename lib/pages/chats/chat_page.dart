import 'package:app/constants.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_body.dart';
import 'package:app/widgets/all_chats_page/chat_page/icon_buttom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        // toolbarHeight: ,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              user.userName,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Active Now',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          size: 35,
          color: Colors.white,
        ),
        actions: [
          CustomIconButton(
            icon: Icons.call,
          ),
          CustomIconButton(
            icon: FontAwesomeIcons.video,
          ),
          CustomIconButton(
            icon: Icons.error,
          ),
        ],
      ),
      body: ChatPageBody(),
    );
  }
}
