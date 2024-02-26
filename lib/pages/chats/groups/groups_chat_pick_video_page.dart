import 'dart:io';

import 'package:app/common/navigation.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_text_field.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_send_chat_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class GroupsChatPickVideoPage extends StatefulWidget {
  const GroupsChatPickVideoPage(
      {super.key, required this.video, required this.groupModel});
  final File video;
  final GroupModel groupModel;

  @override
  State<GroupsChatPickVideoPage> createState() =>
      _GroupsChatPickVideoPageState();
}

class _GroupsChatPickVideoPageState extends State<GroupsChatPickVideoPage> {
  late VideoPlayerController _videoPlayerController;
  TextEditingController controller = TextEditingController();
  late bool _isPlaying;
  bool isClick = false;

  @override
  void initState() {
    super.initState();
    _isPlaying = false;
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    )..initialize().then((_) {
        _videoPlayerController.setLooping(false);
        _isPlaying = true;
        _videoPlayerController.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      setState(() {
        _isPlaying = false;
        _videoPlayerController.pause();
        _videoPlayerController.seekTo(Duration.zero);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.removeListener(_videoListener);
    _videoPlayerController.dispose();
  }

  navigation() {
    Navigation.navigationOnePop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sendMessage = context.read<GroupMessageCubit>();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
            } else {
              _videoPlayerController.play();
            }
            _isPlaying = !_isPlaying;
          });
        },
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: VideoPlayer(_videoPlayerController)),
            ),
            Positioned(
                top: size.height * .08,
                left: size.width * .05,
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(FontAwesomeIcons.xmark, color: Colors.white))),
            Positioned(
              height: size.height * .18,
              width: size.width,
              bottom: 0.0,
              child: PickChatTextField(
                controller: controller,
                hintText: 'Enter a message..',
              ),
            ),
            Positioned(
              width: size.width,
              bottom: size.height * .015,
              child: GroupsChatSendItemChatBottom(
                groupModel: widget.groupModel,
                isClick: isClick,
                onTap: () async {
                  try {
                    setState(() {
                      isClick = true;
                    });
                    await sendMessage.sendGroupMessage(
                        messageText: controller.text,
                        groupID: widget.groupModel.groupID,
                        image: null,
                        video: widget.video);
                    navigation();
                  } finally {
                    setState(() {
                      isClick = false;
                    });
                  }
                },
              ),
            ),
            if (!_videoPlayerController.value.isPlaying)
              Positioned.fill(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Color(0xff585558).withOpacity(.3),
                    child: Icon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: size.width * .05,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
