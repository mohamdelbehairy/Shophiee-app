import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/show_chat_media/show_chat_media_appbar.dart';
import 'package:app/widgets/show_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShowChatImagePage extends StatefulWidget {
  const ShowChatImagePage(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  State<ShowChatImagePage> createState() => _ShowChatImagePageState();
}

class _ShowChatImagePageState extends State<ShowChatImagePage> {
  bool isClick = true;
  showToastMethod() {
    ShowToast(
        context: context,
        showToastText: 'Saved successfully',
        position: StyledToastPosition.bottom);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isClick
          ? AppBar(
              backgroundColor: kPrimaryColor,
              titleSpacing: size.width * -.02,
              title: ShowChatMediaAppBar(
                message: widget.message,
                user: widget.user,
                saveOnTap: () async {
                  final tempDir = await getTemporaryDirectory();
                  final fileName =
                      'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
                  final path = '${tempDir.path}/$fileName';
                  await Dio().download(widget.message.messageImage!, path);
                  await GallerySaver.saveImage(path, albumName: 'Sophiee');
                  showToastMethod();
                },
                shareOnTap: () async {
                  final url = Uri.parse(widget.message.messageImage!);
                  final response = await http.get(url);
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final path = '${temp.path}/image.jpg';
                  File(path).writeAsBytesSync(bytes);

                  await Share.shareXFiles([XFile(path)]);
                },
              ))
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
