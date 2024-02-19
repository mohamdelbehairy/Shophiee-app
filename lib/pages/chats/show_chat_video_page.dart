import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/show_chat_media/show_chat_media_appbar.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class ShowChatVideoPage extends StatefulWidget {
  const ShowChatVideoPage(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  State<ShowChatVideoPage> createState() => _ShowChatVideoPageState();
}

class _ShowChatVideoPageState extends State<ShowChatVideoPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late bool _isVideoPlaying;

  @override
  void initState() {
    super.initState();
    _isVideoPlaying = false;

    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.message.messageVideo!));

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showOptions: false,
    );
    _videoPlayerController.addListener(() {
      final isPlaying = _videoPlayerController.value.isPlaying;
      if (isPlaying != _isVideoPlaying) {
        setState(() {
          _isVideoPlaying = isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: !_isVideoPlaying
          ? AppBar(
              titleSpacing: size.width * -.02,
              backgroundColor: kPrimaryColor,
              title: ShowChatMediaAppBar(
                  message: widget.message,
                  user: widget.user,
                  saveOnTap: () {},
                  shareOnTap: () async {
                    final url = Uri.parse(widget.message.messageVideo!);
                    final response = await http.get(url);
                    final bytes = response.bodyBytes;
                    final temp = await getTemporaryDirectory();
                    final path = '${temp.path}/video.mp4';
                    File(path).writeAsBytesSync(bytes);

                    await Share.shareXFiles([XFile(path)]);
                  }),
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
            ),
      body: Chewie(controller: _chewieController),
    );
  }
}
