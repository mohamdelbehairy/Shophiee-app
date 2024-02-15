import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/show_chat_image/show_chat_image_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class ShowChatImagePage extends StatefulWidget {
  const ShowChatImagePage(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  State<ShowChatImagePage> createState() => _ShowChatImagePageState();
}

class _ShowChatImagePageState extends State<ShowChatImagePage> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isClick
          ? AppBar(
              backgroundColor: kPrimaryColor,
              titleSpacing: size.width * -.02,
              title: ShowChatImageAppBar(
                  message: widget.message, user: widget.user),
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false),
      body: Padding(
        padding: EdgeInsets.only(top: size.height * .06),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isClick = !isClick;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      CachedNetworkImageProvider(widget.message.messageImage!),
                  fit: BoxFit.fitWidth),
            ),
          ),
        ),
      ),
    );
  }
}
